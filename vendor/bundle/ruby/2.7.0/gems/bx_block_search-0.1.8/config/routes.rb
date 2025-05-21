BxBlockSearch::Engine.routes.draw do
  get 'users', to: 'search#users'
  get 'posts', to: 'search#posts'
  get 'messages', to: 'search#messages'
  get 'chats', to: 'search#chats'
  get 'comments', to: 'search#comments'
end
