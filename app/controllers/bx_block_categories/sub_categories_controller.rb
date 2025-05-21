module BxBlockCategories
  class SubCategoriesController < ApplicationController
    include BxBlockCatalogue::CatalogueSearch
    before_action :load_category, only: [:show, :index]
    before_action :load_sub_category, only: [:show]

    def show
      render json: SubCategorySerializer.new(@sub_category).serializable_hash,status: :ok
    end

    def index
      @sub_categories = @category.sub_categories.all

      render json: SubCategorySerializer.new(@sub_categories).serializable_hash, status: :ok
    end

    def list_sub_categories_from_catalogues
      deal = BxBlockCatalogue::Deal.all.active_deals.find_by(id: params[:deal_id])

      return render json: { error: "Deal not found" }, status: :not_found unless deal.present?

      if deal.present?
        catalogues_ids = catalogues_by_active_deals(params[:deal_id])
        @sub_categories = SubCategory.includes(:catalogues).where(catalogues: {id: catalogues_ids})
        render json: SubCategorySerializer.new(@sub_categories).serializable_hash, status: :ok
      end

    end

    def list_subcategories_by_category_ids
      @sub_categories = SubCategory.includes(:category).where(parent_id: params[:category_ids])
      render json: SubCategorySerializer.new(@sub_categories).serializable_hash, status: :ok
    end

    private

    def load_sub_category
      @sub_category = @category.sub_categories.find_by(id: params[:id])

      if @sub_category.nil?
        render json: {
          message: "SubCategory doesn't exists"
        }, status: :not_found
      end
    end

    def load_category
      @category = Category.find(params[:category_id])
    end

  end
end

