FactoryBot.define do
  factory :image_url, class: 'BxBlockCatalogue::ImageUrl' do
    url { "https://fastly.picsum.photos/id/861/200/300.jpg?hmac=kssNLkcAZTJQKpPCSrGodykV8A6CStZxL7dHvtsVUD0" }
    product_content
  end
end
