require 'rails_helper'

RSpec.describe "BxBlockSeoSetting::SeoSettingsController", type: :request do
  before(:all) do
    BxBlockSeoSetting::SeoSetting.all.delete_all
    @seo_setting = FactoryBot.create(:seo_setting) 
  end

  let(:valid_attributes) {
    {
      "data": {
        "attributes": {
          "page_name": "Page#{rand(1000..9999)}",
          "meta_title": "Nam lobortis sapien at dui porta dictum",
          "meta_description": "Suspendisse finibus finibus tortor, vel tincidunt ex gravida mollis."
        }
      }
    }
  }

  let(:invalid_attributes) {
    {
      "data": {
        "attributes": {
          "page_name": nil,
          "meta_title": "eget pulvinar massa sagittis",
          "meta_description": "Proin sed felis sit amet ante blandit scelerisque ac placerat purus."
        }
      }
    }
  }

  describe "GET /index" do
    it "renders a successful response" do
      get bx_block_seo_setting_seo_settings_url
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      get bx_block_seo_setting_seo_setting_url(@seo_setting)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new SeoSetting" do
        expect {
          post bx_block_seo_setting_seo_settings_url, 
          params: valid_attributes
        }.to change(BxBlockSeoSetting::SeoSetting, :count).by(1)
      end

      it "renders a JSON response with the new seo_setting" do
        post bx_block_seo_setting_seo_settings_url,
        params:valid_attributes
        expect(response).to have_http_status(:created)
      end
    end

    context "with invalid parameters" do
      it "does not create a new SeoSetting" do
        expect {
          post bx_block_seo_setting_seo_settings_url,
          params: invalid_attributes 
        }.to change(BxBlockSeoSetting::SeoSetting, :count).by(0)
      end

      it "renders a JSON response with errors for the new seo_setting" do
        post bx_block_seo_setting_seo_settings_url,
        params: invalid_attributes 
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        {
      "data": {
        "attributes": {
          "meta_description": "ante blandit scelerisque ac placerat purus.Proin sed felis sit amet"
        }
      }
    }
      }


      it "renders a JSON response with the seo_setting" do
        patch bx_block_seo_setting_seo_setting_url(@seo_setting),
        params: new_attributes
        expect(response).to have_http_status(:ok)
      end
    end

    context "with invalid parameters" do
      it "renders a JSON response with errors for the seo_setting" do
        patch bx_block_seo_setting_seo_setting_url(@seo_setting),
        params: invalid_attributes 
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested seo_setting" do
      expect {
        delete bx_block_seo_setting_seo_setting_url(@seo_setting)
      }.to change(BxBlockSeoSetting::SeoSetting, :count).by(-1)
    end
  end
end
