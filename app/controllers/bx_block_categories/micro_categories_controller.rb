module BxBlockCategories
  class MicroCategoriesController < ApplicationController
    before_action :load_mini_category
    before_action :load_micro_category, only: [:show]

    def show
      render json: MicroCategorySerializer.new(@micro_category).serializable_hash,status: :ok
    end

    def index
      @micro_categories = @mini_category.micro_categories.all

      render json: MicroCategorySerializer.new(@micro_categories).serializable_hash, status: :ok
    end

     def list_microcategories_by_minicategory_ids
      @micro_categories = MicroCategory.includes(:mini_category).where(mini_category_id: params[:mini_category_ids])
      render json: MicroCategorySerializer.new(@micro_categories).serializable_hash, status: :ok
    end

    private

    def load_micro_category
      @micro_category = @mini_category.micro_categories.find_by(id: params[:id])

      if @micro_category.nil?
        render json: {
          message: "MicroCategory doesn't exists"
        }, status: :not_found
      end
    end

    def load_mini_category
      @mini_category = MiniCategory.find_by(id: params[:mini_category_id])
    end

  end
end

