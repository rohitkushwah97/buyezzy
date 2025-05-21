module BxBlockCatalogue
  class ProductVariantGroupsController < ApplicationController

    before_action :set_catalogue
    before_action :set_product_variant_group, only: [:show, :update, :destroy]
    before_action :validate_json_web_token, only: [:create, :update, :destroy]

    def create
      ActiveRecord::Base.transaction do
        product_variant_groups = []

        params['_json'].each do |variant_group_params|
          product_variant_group = @catalogue.product_variant_groups.new(
            product_sku: variant_group_params["product_sku"],
            catalogue_variant_id: variant_group_params["catalogue_variant_id"]
            )

          variant_group_params["group_attributes_attributes"].each do |group_attribute_params|
            product_variant_group.group_attributes.build(group_attribute_params.permit("attribute_option_id","variant_attribute_id","attribute_name", "option"))
          end

          if product_variant_group.save
            product_variant_groups << product_variant_group
            product_variant_group.create_and_associate_variant_product
          else
            render json: { errors: product_variant_group.errors.full_messages.map {|message| message.gsub("Product ","")} }, status: :unprocessable_entity
            raise ActiveRecord::Rollback
          end
        end

        render json: BxBlockCatalogue::ProductVariantGroupSerializer.new(product_variant_groups).serializable_hash, status: :created
      end
    end

    def index
      render json: BxBlockCatalogue::ProductVariantGroupSerializer.new(@catalogue.product_variant_groups).serializable_hash, status: :ok
    end

    def show
      render json: BxBlockCatalogue::ProductVariantGroupSerializer.new(@product_variant_group).serializable_hash, status: :ok
    end

    def update
      if @product_variant_group.update(product_variant_groups_params)
        render json: BxBlockCatalogue::ProductVariantGroupSerializer.new(@product_variant_group).serializable_hash, status: :ok
      else
        render json: { errors: format_activerecord_errors(@product_variant_group.errors) }, status: :unprocessable_entity
      end
    end

    def destroy

      if @product_variant_group.destroy
        render json: {message: "Product variant Destroyed"}, status: :ok
      end

    end

    private

    def set_catalogue
      @catalogue = Catalogue.find(params[:catalogue_id])
    end

    def set_product_variant_group
      @product_variant_group = BxBlockCatalogue::ProductVariantGroup.find(params[:id])
    end

    def product_variant_groups_params
      params.permit(:catalogue_variant_id, :product_sku, :product_description, :price, :product_title,
       product_images: [],
       group_attributes_attributes: [
        :id,
        :variant_attribute_id,
        :attribute_option_id,
        :attribute_name,
        :option,
        :_destroy
      ]
      )
    end
  end
end
