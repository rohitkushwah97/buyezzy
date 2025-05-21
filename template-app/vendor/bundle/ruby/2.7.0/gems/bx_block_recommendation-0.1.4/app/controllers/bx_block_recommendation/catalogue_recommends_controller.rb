# frozen_string_literal: true

module BxBlockRecommendation
  class CatalogueRecommendsController < ApplicationController
    include BuilderJsonWebToken::JsonWebTokenValidation

    before_action :find_user_wish_list, only: %i[custom_recommendation_setting]
    before_action :find_wish_list_products, only: %i[custom_recommendation_setting]
    before_action :find_query, only: %i[custom_recommendation_setting]
    before_action :validate_json_web_token, only: %i[custom_recommendation_setting]
    before_action :current_user, only: %i[custom_recommendation_setting]

    def default_recommendation_setting
      products = []
      products.concat(most_sold_products_in, recent_sold_product_in, specific_category_in)
      products = products.flatten.uniq

      render json: BxBlockRecommendation::CatalogueRecommendsSerializer.new(products,serialization_options).serializable_hash
    end

    def custom_recommendation_setting
      @products_item = []
      recommand_types = BxBlockRecommendation::CatalogueRecommend.where(value: true)
      recommand_types.each do |recommand|

        case recommand.recommendation_setting
        when 'wishlist_products'
          @products_item.concat(wishlist_products)
        when 'match_previous_orders'
          wishlist = user_previous_order_products
          @products_item.concat(wishlist) if wishlist.present?
        when 'similar_product_category_type'
          @products_item.concat(similar_category_products)
        when 'similar_color'
          @products_item.concat(similar_color_products)
        when 'similar_product_size'
          @products_item.concat(similar_size_products)
        else
          'Recommendation Setting Not Available'
        end
      end
      @products_item = @products_item.flatten.uniq

      render json: BxBlockRecommendation::CatalogueRecommendsSerializer.new(@products_item,serialization_options).serializable_hash
    end

    def most_sold_products
      render json: most_sold_products_in
    end

    def recent_sold_product
      render json: recent_sold_product_in
    end

    def specific_category
      render json: specific_category_in
    end

    def wishlist_products
      @products&.take(10)
    end

    def user_previous_order_products
      product = []
      orders = @current_user&.manage_orders&.last(10)
      orders&.each do |order|
        order_items = order&.order_items
        order_items.each do |order_item|
          product << order_item.catalogue
        end
      end
      product.take(10)
    end

    def similar_category_products
      catalogues = []
      @products&.each do |product|
        catalogues << product.catalogue_master.catalogues
      end
      catalogues.take(10)
    end

    def similar_color_products
      catalogues = []

      @products&.each do |_product|
        @catalogues_ids = BxBlockCatalogue::CatalogueVariant.where(catalogue_variant_color_id: params[:variant_color_id]).pluck(:catalogue_id).uniq
        catalogues << BxBlockCatalogue::Catalogue.where(id: @catalogues_ids).where(catalogue_master_id: @catalogue_masters_ids)
      end
      catalogues.take(10)
    end

    def similar_size_products
      @products_item = @products_item.uniq
      catalogues = []
      @products&.each do |_product|
        @catalogues_ids = BxBlockCatalogue::CatalogueVariant.where(catalogue_variant_size_id: variant_size_id).pluck(:catalogue_id).uniq
        catalogues << BxBlockCatalogue::Catalogue.where(id: @catalogues_ids).where(catalogue_master_id: @catalogue_masters_ids)
      end
      catalogues.take(10)
    end

    private

    def find_user_wish_list
      @wishlists = current_user&.customer_wishlists
    end

    def find_wish_list_products
      @products = []
      @wishlists&.each do |wish|
        products << wish.catalogue
      end
      @products = @products.uniq
    end

    def find_query
      @sub_catagory_id = @product&.catalogue_master&.sub_category&.id
      @catalogue_masters_ids = BxBlockCatalogue::CatalogueMaster.where(sub_category_id: @sub_catagory_id).pluck(:id)
    end

    def most_sold_products_in
      product = []
      catalogues = BxBlockCatalogue::Catalogue.all
      catalogues.each do |catalogue|
        product << catalogue
      end
      product.take(10)
      product.uniq
    end

    def recent_sold_product_in
      products = []
      similar_products = []
      orders = BxBlockOrderManagement::Order.last(10)
      orders.each do |order|dont
        order_items = order.order_items
        order_items.each do |order_item|
          products << order_item.catalogue

        end
      end
      products.uniq.each do |product|
        similar_products << product.catalogue_master.catalogues
      end
      similar_products.take(10)
    end

    def specific_category_in
      products = []
      catalogue_master = BxBlockCategories::Category.find_by_name(params[:name])&.catalogue_master
      catalogue_master&.each do |master|
        products << master.catalogues.first
      end
      products = products.uniq
      products.take(10)
    end

    def serialization_options
      { params: { host: request.protocol + request.host_with_port } }
    end
  end
end
