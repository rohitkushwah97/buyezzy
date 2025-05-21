module BxBlockStoreManagement
  class StoreMenusController < ApplicationController
    before_action :set_store
    before_action :set_menu, only: [:show, :update, :destroy]
    before_action :validate_json_web_token, only: [:create, :update, :destroy]

    def index
      @menus = fetch_menus
      render json: StoreMenuSerializer.new(@menus).serializable_hash, status: :ok
    end

    def store_menus_list
      @menus = fetch_menus
      render json: {store_menus: store_menu_response(@menus)}, status: :ok
    end

    def show
      render json: StoreMenuSerializer.new(@menu).serializable_hash, status: :ok
    end

    def create
      @menu = @store.store_menus.create(menu_params)
      if @menu.persisted?
        if params[:catalogue_ids].present?
          catalogue_ids = params[:catalogue_ids]
          @menu.catalogues << BxBlockCatalogue::Catalogue.where(id: catalogue_ids)
        end
        render json: StoreMenuSerializer.new(@menu).serializable_hash, status: :created
      else
        render json: {
          errors: format_activerecord_errors(@menu.errors)
        }, status: :unprocessable_entity
      end
    end

    def update
      if @menu.update(menu_params)
        if params[:catalogue_ids].present?
          catalogue_ids = params[:catalogue_ids]
          @menu.catalogues = BxBlockCatalogue::Catalogue.where(id: catalogue_ids)
        end
        render json: StoreMenuSerializer.new(@menu).serializable_hash, status: :ok
      else
        render json: {
          errors: format_activerecord_errors(@menu.errors)
        }, status: :unprocessable_entity
      end
    end

    def destroy
      if @menu.destroy
        render json: {
          message: "Menu removed"
        }, status: :ok
      end 
    end

    private

    def set_store
      @store = Store.find(params[:store_id])
    end

    def set_menu
      @menu = @store.store_menus.find_by(id: params[:id])
      if @menu.nil?
        render json: {
          message: "Menu not found"
        }, status: :not_found
      end
    end

    def menu_params
      params.permit(:title, :cover_image, :logo, :store_name, :banner_name, :position, :product_quantity)
    end

    def fetch_menus
      @store.store_menus.order(position: :asc)
    end

    def store_menu_response(menus)
      menus.map do |menu|
        {
          id: menu.id,
          store_name: menu.store_name, 
          title: menu.title, 
          banner_name: menu.banner_name, 
          position: menu.position, 
          product_quantity: menu.product_quantity,
          logo: (ENV['BASE_URL'] ? (ENV['BASE_URL'] + Rails.application.routes.url_helpers.rails_blob_path(menu.logo, only_path: true)) : Rails.application.routes.url_helpers.rails_blob_path(menu.logo, only_path: true) if menu.logo.attached?),
          cover_image: (ENV['BASE_URL'] ? (ENV['BASE_URL'] + Rails.application.routes.url_helpers.rails_blob_path(menu.cover_image, only_path: true)) : Rails.application.routes.url_helpers.rails_blob_path(menu.cover_image, only_path: true) if menu.cover_image.attached?),
          store_id: menu.store_id
        }
      end
    end
  end
end
