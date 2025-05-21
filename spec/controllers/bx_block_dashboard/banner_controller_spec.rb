require 'rails_helper'

RSpec.describe BxBlockDashboard::BannersController, type: :controller do

  before do
  	BxBlockDashboard::BannerGroup.all.delete_all
    @category = create(:category) 
    @subcategory = create(:sub_category, category: @category)
    @catalogue = create(:catalogue)
    @deal = create(:deal)
    @banner_group = create(:banner_group, group_name: 'middle_group_2')
    @banner_header = create(:banner, category: @category )
    @banner_group_1 = BxBlockDashboard::BannerGroup.find_or_create_by(group_name: 'middle_group_1')
    @single_image_type = 'single_image'
  end

  describe 'GET #header_slideshow_index' do
    it 'returns a successful response header_slideshow_index' do
      get :header_slideshow_index
      expect(response).to have_http_status(:ok)
      expect(response.body).to include(@banner_header.title)
      expect(response.body).to include(@banner_header.description)
      expect(JSON.parse(response.body)["data"].last["attributes"]).to have_key("banner_image")
    end
  end

  describe 'GET #header_single_images_index' do
    it 'returns a successful response header_single_images_index' do
      banner_header_2 = create(:banner, catalogue: @catalogue , banner_type: @single_image_type)
      get :header_single_images_index
      expect(response).to have_http_status(:ok)
      expect(response.body).to include(banner_header_2.title)
      expect(response.body).to include(banner_header_2.description)
    end
  end

  describe 'GET #middle_slideshow_index' do
    context 'with a valid group_name' do
      it 'returns a successful response middle_slideshow_index' do
        banner_middle_1 = create(:banner, section: 'middle', sub_category: @subcategory, banner_group: @banner_group_1)
        get :middle_slideshow_index, params: { group_name: 'middle_group_1' }
        expect(response).to have_http_status(:ok)
        expect(response.body).to include(banner_middle_1.title)
        expect(response.body).to include(banner_middle_1.description)
      end
    end

    context 'with a missing group_name' do
      it 'returns a not found response' do
        get :middle_slideshow_index
        expect(response).to have_http_status(:not_found)
        expect(response.body).to include('group_name params is missing')
      end
    end
  end

  describe 'GET #middle_single_images_index' do
    it 'returns a successful response middle_single_images_index' do
      banner_middle_2 = create(:banner, section: 'middle', deal: @deal, banner_type: @single_image_type, banner_group: nil)

      get :middle_single_images_index
      expect(response).to have_http_status(:ok)
      expect(response.body).to include(banner_middle_2.title)
      expect(response.body).to include(banner_middle_2.description)
    end
  end

  describe 'GET #footer_single_images_index' do
    it 'returns a successful response footer_single_images_index' do
      banner_footer = create(:banner, section: 'footer', category: @category, banner_type: @single_image_type)

      get :footer_single_images_index
      expect(response).to have_http_status(:ok)
      expect(response.body).to include(banner_footer.title)
      expect(response.body).to include(banner_footer.description)
    end
  end

  describe 'GET #top_banners' do
    it 'returns a successful response top_banners' do
      top_banner = BxBlockDashboard::Banner.find_or_create_by(title: "Free shipping on all UAE orders AED 200", button_text: "SHOP NOW",banner_type: "top_banner", button_link: "https://www.url.com", status: true)

      get :top_banner
      expect(response.body).to include(top_banner.title)
      expect(response.body).to include(top_banner.button_text)
    end
  end
end
