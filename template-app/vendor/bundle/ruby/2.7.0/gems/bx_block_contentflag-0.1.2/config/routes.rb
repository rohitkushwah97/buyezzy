BxBlockContentflag::Engine.routes.draw do
  resources :contents
  resources :building_blocks
  post "/comments" => "contents#flag_comment"
  get "/flag_reasons" => "building_blocks#flag_category"
end
