module BxBlockSeoSetting
  class SeoSettingsController < ApplicationController
    before_action :set_seo_setting, only: [:show, :update, :destroy]

    def index
      @seo_settings = SeoSetting.all.order(created_at: :desc)
      if @seo_settings.present?
        render json: SeoSettingSerializer.new(@seo_settings, meta: { message: "Successfully Loaded" }).serializable_hash, status: :ok
      else
        render json: { message: "No SEO settings found" }, status: :not_found
      end
    end

    def show
      render json: SeoSettingSerializer.new(@seo_setting).serializable_hash, status: :ok
    end

    def create
      @seo_setting = SeoSetting.new(seo_setting_params)
      if @seo_setting.save
        render json: SeoSettingSerializer.new(@seo_setting).serializable_hash, status: :created
      else
        render json: @seo_setting.errors, status: :unprocessable_entity
      end
    end

    def update
      if @seo_setting.update(seo_setting_params)
        render json: SeoSettingSerializer.new(@seo_setting).serializable_hash, status: :ok
      else
        render json: @seo_setting.errors, status: :unprocessable_entity
      end
    end

    def destroy
      if @seo_setting&.destroy
        render json:{ meta: { message: "seo setting Removed"}}
      else
        render json:{meta: {message: "Record not found."}}
      end
    end

    private
    def set_seo_setting
      @seo_setting = SeoSetting.find(params[:id])
    end

    def seo_setting_params
      jsonapi_deserialize(params)
    end
  end
end
