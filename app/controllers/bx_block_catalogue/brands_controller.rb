module BxBlockCatalogue
  class BrandsController < ApplicationController
    include BxBlockCatalogue::CatalogueSearch
    before_action :validate_json_web_token, only: [:show, :create, :seller_brand_listing, :update_seller_brands, :delete_seller_brand, :create_seller_brand, :search_brands]
    before_action :get_account, only: [:seller_brand_listing, :update_seller_brands, :create_seller_brand, :delete_seller_brand, :search_brands]
    before_action :get_brand, only: [:update_seller_brands, :delete_seller_brand]
    before_action :check_seller_user, only: [:search_brands, :update_seller_brands, :seller_brand_listing, :create_seller_brand, :delete_seller_brand]

    def create
      @brand = Brand.new(brand_params)

      if @brand.save
        render json: BrandSerializer.new(@brand).serializable_hash,
        status: :created
      else
        render json: { errors: format_activerecord_errors(@brand.errors) },
        status: :unprocessable_entity
      end
    end

    def index
      serializer = BrandSerializer.new(Brand.all)

      render json: serializer, status: :ok
    end

    def approved_brands_index
      render json: BrandSerializer.new(Brand.all.where(approve: true)), status: :ok
    end

    def restricted_brands_index
      render json: BrandSerializer.new(Brand.all.where(restricted: true)), status: :ok
    end

    def gated_brands_index
      render json: BrandSerializer.new(Brand.all.where(gated: true)), status: :ok
    end

    def create_seller_brand
      brand = @account.brands.new(brand_params)
      if brand.save
        render json: BrandSerializer.new(brand).serializable_hash, status: :created
      else
        render json: { errors: brand.errors.full_messages }, status: :unprocessable_entity
      end
    end

    def seller_brand_listing
      render json: BrandSerializer.new(@account.brands), status: :ok
    end

    def update_seller_brands
      if @brand.update(brand_params)
        render json: BrandSerializer.new(@brand).serializable_hash, status: :ok
      else
        render json: { errors: @brand.errors.full_messages }, status: :unprocessable_entity
      end
    end

    def delete_seller_brand
      begin
        if @brand.destroy
          render json: { message: 'Brand deleted successfully' }, status: :ok
        end
      rescue => e
        render json: { errors: @brand.errors.full_messages }, status: :unprocessable_entity
      end
    end

    def search_brands
      if params[:keyword].present?
        keyword = params[:keyword].to_s.strip
        @brands = Brand.where("brand_name ILIKE ? AND approve = ?", "%#{keyword}%", true)
        if @brands.exists?
          render json: brand_list_responses(@brands, @account), status: :ok
        else
          render json: {
            message: "Brand not found"
          }, status: :not_found
        end
      else
        render json: { message: "Keyword is missing" }, status: :bad_request
      end
    end

    def list_sub_categories_from_brand
      brand = Brand.all.find_by(id: params[:brand_id], approve: true)
      catalogues_ids = []

      return render json: { error: "subcategories not found" }, status: :not_found unless brand.present?

      if brand.present?
        catalogues_ids = brand.catalogues.pluck(:id)
      end

      sub_categories = BxBlockCategories::SubCategory.includes(:catalogues).where(catalogues: {id: catalogues_ids})
      render json: BxBlockCategories::SubCategorySerializer.new(sub_categories).serializable_hash, status: :ok
    end

    def show
      @brand = Brand.find_by(id: params[:id])

      if @brand.present?
        render json: BrandSerializer.new(@brand).serializable_hash, status: :ok
      else
        render json: {
          message: "Brand with id #{params[:id]} doesn't exists"
        }, status: :not_found
      end
    end

    def list_brands_from_catalogues
      category_id = params[:category_id]
      deal_id = params[:deal_id]

      if category_id.present?
        brands = Brand.includes(catalogues: :category).where(categories: { id: category_id }).distinct
        render_brands(brands)
      elsif deal_id.present?
        catalogues_ids = catalogues_by_active_deals(deal_id)
        brands = Brand.includes(:catalogues).where(catalogues: { id: catalogues_ids }).distinct
        render_brands(brands)
      else
        render json: {
          message: "Category ID or Deal ID is required"
        }, status: :bad_request
      end
    end

    private

    def get_account
      @account = AccountBlock::Account.find_by(id: @token.id)
    end

    def get_brand
      @brand = Brand.find_by(id: params[:id]) 
      if @brand.nil?
        render json: {
          message: "Brand with id #{params[:id]} doesn't exists"
        }, status: :not_found
      end
    end

    def check_seller_user
      return render json: { errors: [{ message: "You are not authorized to access brands" }] }, status: :forbidden unless @account&.user_type == 'seller'
    end

    def brand_params
      params.permit(:id, :brand_name, :brand_name_arabic,:brand_website,:brand_year, :brand_image, :branding_tradmark_certificate, :approve, :restricted, :gated)
    end

    def format_activerecord_errors(errors)
      result = []
      errors.each do |attribute, error|
        attribute_name = attribute.to_s.gsub('_', ' ')
        result << "#{attribute_name.capitalize} #{error}"
      end
      result
    end

    def user_brand_details(seller, brand)
      user_details = {'current_owner': false, 'restricted_request_exist': false, 'permission_granted': false}
      
      user_details['current_owner'] = true if brand.account_id == seller&.id

      user_details['restricted_request_exist'] = true if brand.restricted_brands.where(seller_id: seller&.id).present?

      user_details['permission_granted'] = true if brand.restricted_brands.where(seller_id: seller&.id, approved: true).present?

      user_details
      
    end

    def fetch_asset_url(asset)
      if asset&.attached?
        ENV['BASE_URL'] ? (ENV['BASE_URL'] + Rails.application.routes.url_helpers.rails_blob_path(asset, only_path: true)) : Rails.application.routes.url_helpers.rails_blob_path(asset, only_path: true)
      end
    end

    def brand_list_responses(brands, seller)

      brand_results = brands.map do |brand|
        {
          "id": brand.id,
          "brand_name": brand.brand_name,
          "brand_name_arabic": brand.brand_name_arabic,
          "brand_website": brand.brand_website,
          "brand_year": brand.brand_year,
          "account_id": brand.account_id,
          "branding_tradmark_certificate": fetch_asset_url(brand.branding_tradmark_certificate),
          "brand_image": fetch_asset_url(brand.brand_image),
          "approve": brand.approve,
          "restricted": brand.restricted,
          "gated": brand.gated,
          "created_at": brand.created_at,
          "updated_at": brand.updated_at,
        }.merge(user_brand_details(seller, brand))
      end

      brand_results || []

    end

    def render_brands(brands)
      render json: BrandSerializer.new(brands).serializable_hash, status: :ok
    end

  end
end
