module BxBlockChat
  class ChatsController < ApplicationController
    before_action :find_chat, only: [:read_messages]

    def index
      chats = current_user.chats
      if chats.present?
        render json: ::BxBlockChat::ChatOnlySerializer.new(chats, serialization_options).serializable_hash, status: :ok
      else
        render json: {message: "chat data is not present"}, status: :unprocessable_entity
      end
    end

    def show
      chat = BxBlockChat::Chat.includes(:accounts).find(params[:id])
      render json: ::BxBlockChat::ChatSerializer.new(chat, serialization_options).serializable_hash, status: :ok
    end

    def mychats
      chat_ids = AccountBlock::Account.find(current_user.id).chats.pluck(:id)
      chats = current_user.chats.where(id: chat_ids)
      params[:receiver_id] = current_user.id
      render json: ::BxBlockChat::ChatMyChatSerializer.new(chats, chat_message_serialization_options).serializable_hash, status: :ok
    end

    def create
      chat = BxBlockChat::Chat.new(chat_params)
      chat.chat_type = "multiple_user"
      if chat.save
        BxBlockChat::AccountsChatsBlock.create(account_id: current_user.id,
          chat_id: chat.id,
          status: :admin)
        render json: ::BxBlockChat::ChatSerializer.new(chat, serialization_options).serializable_hash, status: :created
      else
        render json: {errors: chat.errors}, status: :unprocessable_entity
      end
    end

    def history
      chat_ids = AccountBlock::Account.find(params[:receiver_id]).chats.pluck(:id)
      chats = current_user.chats.where(id: chat_ids)
      if chats.present?
        render json: ::BxBlockChat::ChatHistorySerializer.new(chats, chat_message_serialization_options).serializable_hash, status: :ok
      else
        render json: {message: "They don't have any chat history"}, status: :unprocessable_entity
      end
    end

    def read_messages
      @chat.messages.each do |chatdata|
        unless chatdata.read_by.include?(current_user.id)
          read_by_array = chatdata.read_by << current_user.id
          chatdata.update(is_mark_read: true, read_by: read_by_array)
        end
      end
      @chat.create_activity(key: "bx_block_chat.readmessage_on", owner: current_user)
      render json: ::BxBlockChat::ChatSerializer.new(@chat, serialization_options).serializable_hash, status: :ok
    rescue => e
      render json: {error: e}
    end

    def update
      chat = Chat.find(params[:id])
      if !params[:chat][:name].nil?
        Chat.where(id: chat.id).update(name: params[:chat][:name])
        current_user.accounts_chats.find_by(chat_id: chat.id)&.update(muted: params[:chat][:muted])
      end
      if !params[:chat][:muted].nil?
        current_user.accounts_chats.where(chat_id: chat.id).first.update(muted: params[:chat][:muted])
      end
      chat.reload
      if chat.present?
        render json: ::BxBlockChat::ChatSerializer.new(
          chat, serialization_options
        ).serializable_hash, status: :ok
      else
        render json: {errors: format_activerecord_errors(chat.errors)},
          status: :unprocessable_entity
      end
    end

    def search
      @chats = current_user
        .chats
        .where("name ILIKE :search", search: "%#{search_params[:query]}%")
      render json: ChatSerializer.new(@chats, serialization_options).serializable_hash, status: :ok
    end

    def search_messages
      @messages = ChatMessage
        .where(chat_id: current_user.chat_ids)
        .where("message ILIKE :search", search: "%#{search_params[:query]}%")
      render json: ChatMessageSerializer.new(@messages, serialization_options).serializable_hash, status: :ok
    end

    private

    def chat_params
      params.require(:chat).permit(:name)
    end

    def search_params
      params.permit(:query)
    end

    def find_chat
      @chat = Chat.find_by_id(params[:chat_id])
      if @chat.nil?
        render json: {message: "Chat room is not valid or no longer exists"}, status: :not_found
      end
    end
  end
end
