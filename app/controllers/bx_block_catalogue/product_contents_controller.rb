module BxBlockCatalogue
  class ProductContentsController < ApplicationController
    before_action :set_catalogue
    before_action :validate_json_web_token, only: [:create, :update]

    def index
      @product_content = @catalogue.product_content
      render json: ProductContentSerializer.new(@product_content).serializable_hash, status: :ok
    end

    # def show
    #   @product_content = @catalogue.product_content
    #   render json: @product_content
    # end

    def create
      @product_content = @catalogue.product_content

      @product_content ||= ProductContent.new(catalogue: @catalogue)
      @product_content.assign_attributes(product_content_params.except(:catalogue_content_attributes))

      if @product_content.save
        update_catalogue_content
        render json: ProductContentSerializer.new(@product_content).serializable_hash, status: :created
      else
        render json: { errors: format_activerecord_errors(@product_content.errors) }, status: :unprocessable_entity
      end
    end

    def update
      @product_content = ProductContent.find(params[:id])

      if @product_content.update(product_content_params.except(:catalogue_content_attributes))
        update_catalogue_content
        render json: ProductContentSerializer.new(@product_content).serializable_hash, status: :ok
      else
        render json: { errors: format_activerecord_errors(@product_content.errors) }, status: :unprocessable_entity
      end
    end

    private

    def set_catalogue
      @catalogue = Catalogue.find(params[:catalogue_id])
    end

    def product_content_params
      params.require(:data)
      .require(:attributes)
      .permit(:gtin, :unique_psku, :brand_name, :product_title, :mrp, :retail_price, :long_description, :whats_in_the_package, :country_of_origin,:product_color, :warranty_days,:warranty_months, :dispenser_type, :scent_type, :target_use, :style_name,
        size_and_capacity_attributes: [:id, :size, :size_unit, :hs_code, :prod_model_name, :capacity, :capacity_unit, :prod_model_number, :number_of_pieces],
        shipping_detail_attributes: [:id, :shipping_length, :shipping_length_unit, :shipping_height, :shipping_height_unit, :shipping_width, :shipping_width_unit, :shipping_weight, :shipping_weight_unit],
        image_urls_attributes: [:id, :url, :_destroy],
        feature_bullets_attributes: [:id, :field_name, :value, :_destroy],
        special_features_attributes: [:id, :field_name, :value],
        catalogue_content_attributes: [:id, :custom_field_name, :value])
    end

    # as this is working tested with extra method but without this its working so commenting

    # def update_associated_content
    #   @product_content.image_urls.each do |image_url|
    #     image_url.destroy if image_url._destroy == true
    #   end

    #   @product_content.feature_bullets.each do |feature_bullet|
    #     feature_bullet.destroy if feature_bullet._destroy == true
    #   end

    # end

    def update_catalogue_content
      catalogue_content_attributes = product_content_params.delete(:catalogue_content_attributes)
      return if catalogue_content_attributes.blank?

      catalogue_content_attributes.each do |attr|
        catalogue_content_id = attr[:id]
        value = attr[:value]

        catalogue_content = @catalogue.catalogue_contents.find_by(id: catalogue_content_id)
        next if catalogue_content.blank?
        catalogue_content.update(value: value, custom_field_name: catalogue_content&.custom_field&.field_name)
      end
    end

  end
end
