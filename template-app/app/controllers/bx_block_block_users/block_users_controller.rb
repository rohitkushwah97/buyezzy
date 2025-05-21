module BxBlockBlockUsers
  class BlockUsersController < ApplicationController
    before_action :current_user

    def index
      page = params[:page].to_i == 0 ? 1 : params[:page].to_i
      per_page = params[:per_page].to_i
      @list_blocked_users = BlockUser.where('current_user_id = ?', current_user.id)
      paginated_blocked_users = @list_blocked_users.page(page).per(per_page)
      if paginated_blocked_users.present?
        render json: BlockUsersSerializer.new(paginated_blocked_users, meta: {
          message: 'List of blocked users.',
          pagination: {
            current_page: paginated_blocked_users.current_page,
            per_page: paginated_blocked_users.limit_value,
            total_pages: paginated_blocked_users.total_pages,
            total_items: paginated_blocked_users.total_count
          }
        }).serializable_hash, status: :ok
      else
        render json: {errors: [{message: 'No user blocked.'}]}, status: :ok
      end
    end

    def create
      account_params = jsonapi_deserialize(params)
      account_id = params[:data][:attributes][:account_id].to_i
      #If user try to block self
      return render json: {errors: [{message: 'You cannot block yourself.'},
      ]}, status: :unprocessable_entity if current_user.id == account_id

      #Check if blocked user present
      begin
        @account = AccountBlock::Account.find(account_id)
      rescue ActiveRecord::RecordNotFound => e
        return render json: {errors: [{message: 'User does not exist.'},
        ]}, status: :unprocessable_entity
      end
      #If user already blocked
      @user_blocked = BxBlockBlockUsers::BlockUser.find_by(current_user_id: current_user.id, account_id: @account&.id)
      return render json: {errors: [{message: 'User already blocked.'},
      ]}, status: :unprocessable_entity if @user_blocked.present?
      @blocked_account = BxBlockBlockUsers::BlockUser.new(account_params.merge(current_user_id: current_user.id))
      if @blocked_account.save
        render json: BlockUsersSerializer.new(@blocked_account, meta: {message: 'User blocked.'
        }).serializable_hash, status: :created
      else
        render json: {errors: format_activerecord_errors(@blocked_account.errors)},
               status: :unprocessable_entity
      end
    end

    def destroy
      @block_user =  BxBlockBlockUsers::BlockUser.find_by(id: params[:id])
      return render json: {errors: [{message: 'User not found.'}
      ]}, status: :unprocessable_entity unless @block_user.present?

      if @block_user.destroy
        render json: {message: 'User unblocked.'}, status: :ok
      else
        render json: {errors: [{message: 'User not unblock.'}]}, status: :unprocessable_entity
      end
    end
    
    private

    def encode(id)
      BuilderJsonWebToken.encode id
    end
  end
end
