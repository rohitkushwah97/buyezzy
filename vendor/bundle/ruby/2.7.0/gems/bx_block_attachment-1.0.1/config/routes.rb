BxBlockAttachment::Engine.routes.draw do
  resources :attachments, only: %i(create destroy) do
    member do
      get '/get_user_attachments' => '/attachment_block/attachments#get_user_attachments'
      patch '/save_print_properties' => '/attachment_block/attachments#save_print_properties'
      post '/set_is_printed' => '/attachment_block/attachments#set_is_printed'
    end
  end

  resources :file_attachments, only: %i[create index show destroy update]
end
