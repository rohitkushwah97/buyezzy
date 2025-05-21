module BxBlockAddfriends
  class ConnectionsController < ApplicationController
    include BuilderJsonWebToken::JsonWebTokenValidation
    before_action :set_connection, only: :destroy
    # before_action :current_user
    def index
      @accounts = AccountBlock::Account.where.not(id: current_user.id)
      render json: AccountBlock::AccountSerializer.new(@accounts, { params: { current_user_id: current_user.id } }).serializable_hash,status: :ok
    end

    def my_connections
      my_connections_list = BxBlockAddfriends::Connection.where('receipient_id = ? OR account_id = ?', current_user.id, current_user.id).where(status: 'approved')
      # connections = current_user&.connections.where(status: 'approved')
      # accounts = AccountBlock::Account.where(id: connections.map{|c| c.account_id != current_user.id ? c.account_id : c.receipient_id})
      if my_connections_list.present?
        render json: MyConnectionSerializer.new(my_connections_list, serialization_options).serializable_hash.merge(connection_count: my_connection_count(my_connections_list)), status: :ok
      else
        render json: { message: "Record not found!" }, status: :not_found
      end
    end

    def create
      @connection = BxBlockAddfriends::Connection.where('receipient_id = ? AND account_id = ? OR account_id = ? AND receipient_id = ?', params[:connection][:receipient_id], params[:connection][:account_id],params[:connection][:account_id],params[:connection][:receipient_id])
      if @connection.blank?
        @connection = BxBlockAddfriends::Connection.find_or_create_by(set_connection_params.merge(account_id: current_user.id))
        if @connection.status == "pending"
          user_name = current_user&.profiles&.first&.full_name
          if @connection.save
            message = "new connection request"
            body = user_name.to_s + " " + "sent you the request to connect"
            resource_type = 'connection'
            send_notification(AccountBlock::Account.find_by(id: @connection.receipient_id), message, body, resource_type, @connection, user_name)
            generate_notification(@connection.receipient_id, message, body, @connection.account_id)
            # render json: ConnectionSerializer.new(@connection, serialization_options).serializable_hash, status: :created
            render json: { meta: { message: 'Connection created successfully' } }, status: :created
          else
            render json: { errors: format_activerecord_errors(@connection.errors) },
                   status: :unprocessable_entity
          end
        else
          render json: { message: "Rejected" }
        end
      else
        render json: {errors: 'invaild data'}, status: :unprocessable_entity
      end
    end

    def show
      connection = BxBlockAddfriends::Connection.find_by!(id: params[:id])
      render json: ConnectionSerializer.new(connection, serialization_options).serializable_hash, status: :ok
    end

    # def update
    #   if @connection.present?
    #     @connection.update(set_connection_params(params))
    #     render json: ConnectionSerializer.new(@connection, serialization_options).serializable_hash, status: :ok
    #   else
    #     render json: { errors: format_activerecord_errors(@connection.errors) },
    #            status: :unprocessable_entity
    #   end
    # end

    def destroy
      if @connection&.destroy
        render json: { meta: { message: 'Connection Removed' } }
      else
        render json: { meta: { message: 'Record not found.' } }
      end
    end

    def connection_requests
      # connections = current_user.connections.where(status: 'pending', receipient_id: current_user.id)
      connections = BxBlockAddfriends::Connection.where(receipient_id: current_user&.id, status: 'pending')
      if connections.present?
        render json: Connection2Serializer.new(connections, serialization_options).serializable_hash, status: :ok
      else
        render json: { meta: { message: 'No connection requests' } }, status: :not_found
      end
    end

    def accept_connection
      # connection = current_user.connections.where(receipient_id: params[:receipient_id])
      connection = BxBlockAddfriends::Connection.find_by(receipient_id: current_user.id, account_id: params[:account_id])
      if connection.present?
        connection.update(status: 'approved')
        message = "connection request Accept."
        user_name = current_user&.profiles&.first&.full_name
        body = user_name.to_s + " " + "Accept your connection."
        resource_type = 'connection'
        send_notification(connection&.account, message, body, resource_type, connection, user_name)
        generate_notification(connection.account_id, message, body, connection.receipient_id)
        render json: Connection2Serializer.new(connection, serialization_options).serializable_hash, status: :ok
      else
        render json: {message: 'No requests found!'}, status: :not_found
      end
    end

    def decline_connection
      connection = BxBlockAddfriends::Connection.find_by(receipient_id: current_user.id,
                                                         account_id: params[:account_id])
      if connection.present?
        # connection&.destroy
        connection.update(status: 'ignored')
        render json: { meta: { message: 'Connection Removed' } }, status: :ok
      else
        render json: {message: 'No requests found!'}, status: :not_found
      end
    end

    def recommended_connections
      connections = BxBlockAddfriends::Connection.where(account_id: current_user.id, status: 'approved')
      rec_connections = connections.map { | c | BxBlockAddfriends::Connection.where(account_id: c.receipient_id) }.flatten
      if rec_connections.present?
        render json: ConnectionSerializer.new(rec_connections, serialization_options).serializable_hash, status: :ok
      else
        render json: {message: "Record not found!."}, status: :not_found
      end
    end

    private

    def set_connection_params
      params.require(:connection).permit(:receipient_id)
    end

    def set_connection
      @connection = BxBlockAddfriends::Connection.find(params[:id])
      render json: { message: 'No connection found'} unless @connection.present?
    end

    def current_user
      @account = AccountBlock::Account.find_by(id: @token.id)
    end

    def serialization_options
      { params: { host: request.protocol + request.host_with_port , current_user: current_user } }
    end

    def format_activerecord_errors(errors)
      result = []
      errors.each do |attribute, error|
        result << { attribute => error }
      end
      result
    end

    def generate_notification(account_id, message, body, receipient_id)
      BxBlockPushnotifications::Notification.find_or_create_by(account_id: account_id, message:message, body: body, created_by: receipient_id) rescue nil
    end

    def my_connection_count(my_connections_list)
      my_connections_list&.count
    end
  end
end

