module BxBlockStoreManagement
  class StoresController < ApplicationController
    include BxBlockCatalogue::CatalogueSearch
    before_action :set_store, only: [:show, :update, :destroy, :update_seller_store]
    before_action :validate_json_web_token, only: [:create, :update, :destroy, :seller_store_listing, :update_seller_store, :create_seller_store, :delete_seller_store]
    before_action :get_account, only: [:seller_store_listing, :update_seller_store, :create_seller_store, :delete_seller_store]
    before_action :set_seller_store, only: [:delete_seller_store]

    #listing of stores

    def index
      @stores = Store.all
      render json: StoreSerializer.new(@stores).serializable_hash, status: :ok
    end

    def show
      render json: StoreSerializer.new(@store).serializable_hash, status: :ok
    end

    def index_approved_stores
      @stores = Store.all.where(approve: true).order(created_at: :desc)

      render json: StoreSerializer.new(@stores, message: "Approved Stores Loaded").serializable_hash, status: :ok
    end

    def create
      @store = Store.create(store_params)

      if @store.persisted?
        render json: StoreSerializer.new(@store).serializable_hash, status: :created
      else
        render json: {
          errors: format_activerecord_errors(@store.errors)
        }, status: :unprocessable_entity
      end
    end

    def update
      if @store.update(store_params)
        render json: StoreSerializer.new(@store).serializable_hash, status: :ok
      else
        render json: {
          errors: format_activerecord_errors(@store.errors)
        }, status: :unprocessable_entity
      end
    end

    def destroy
      if @store.destroy
        render json: {
          message: 'Store has been successfully deleted'
        }, status: :ok
      end
    end


    def create_seller_store
      store = @account.stores.new(store_params)
      if store.save
        render json: StoreSerializer.new(store).serializable_hash, status: :created
      else
        render json: { errors: store.errors.full_messages }, status: :unprocessable_entity
      end
    end

    def seller_store_listing
      per_page = params[:per_page].presence&.to_i || 10
      page_number = params[:page].presence&.to_i || 1
      @stores = @account.stores.order(created_at: :desc)
      total_count = @stores.count

      if @stores.present?
        @stores = paginate_catalogues(@stores, page_number, per_page)
      end
      render json: StoreSerializer.new(@stores).serializable_hash.merge(total_count: total_count), status: :ok
    end

    def update_seller_store
      if @store.update(store_params)
        render json: StoreSerializer.new(@store).serializable_hash, status: :ok
      else
        render json: { errors: @store.errors.full_messages }, status: :unprocessable_entity
      end
    end

    def delete_seller_store
      if @store.destroy
        render json: {
          message: 'Store has been successfully deleted'
        }, status: :ok
      end
    end

    private

    def set_store
      @store = Store.find_by(id: params[:id])
      if @store.nil?
        render json: {
          message: "Store with id #{params[:id]} doesn't exists"
        }, status: :not_found
      end
    end

    def set_seller_store
      @store = @account.stores.find_by(id: params[:id])
      if @store.nil?
        render json: {
          message: "This store not belongs to your account or not exists with id #{params[:id]}"
        }, status: :not_found
      end
    end

    def get_account
      @account = AccountBlock::Account.find_by(id: @token.id)
      unless @account && @account.user_type == 'seller'
        return render json: { errors: [{ message: "You are not authorized to access stores" }] }, status: :forbidden
      end
    end

    def store_params
      params.permit(:store_name, :store_year, :store_url, :website_social_url, :brand_trade_certificate, :brand_id)
    end

  end
end