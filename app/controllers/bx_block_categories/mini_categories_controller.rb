module BxBlockCategories
  class MiniCategoriesController < ApplicationController
    before_action :load_sub_category
    before_action :load_mini_category, only: [:show]

    def show
      render json: MiniCategorySerializer.new(@mini_category).serializable_hash,status: :ok
    end

    def index
      @mini_categories = @sub_category.mini_categories.all

      render json: MiniCategorySerializer.new(@mini_categories).serializable_hash, status: :ok
    end

    def list_minicategories_by_subcategory_ids
      @mini_categories = MiniCategory.includes(:sub_category).where(sub_category_id: params[:sub_category_ids])
      render json: MiniCategorySerializer.new(@mini_categories).serializable_hash, status: :ok
    end

    private

    def load_mini_category
      @mini_category = @sub_category.mini_categories.find_by(id: params[:id])

      if @mini_category.nil?
        render json: {
          message: "MiniCategory doesn't exists"
        }, status: :not_found
      end
    end

    def load_sub_category
      @sub_category = SubCategory.find_by(id: params[:sub_category_id])
    end

  end
end

