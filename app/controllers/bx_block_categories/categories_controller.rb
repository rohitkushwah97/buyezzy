module BxBlockCategories
  class CategoriesController < ApplicationController
    before_action :load_category, only: [:show]

    def show
      render json: CategorySerializer.new(@category).serializable_hash,status: :ok
    end

    def index
      @categories = Category.all

      render json: CategorySerializer.new(@categories).serializable_hash, status: :ok
    end

    def search_micro_categories
      render json: {
            message: "Search query is empty"
        }, status: :ok and return unless params[:search_query].present?

      search_query = "%#{params[:search_query].downcase}%"

      @micro_categories = MicroCategory
                        .joins(:category, :sub_category, :mini_category)
                        .where('LOWER(micro_categories.name) LIKE :search_query OR
                                LOWER(categories.name) LIKE :search_query OR
                                LOWER(sub_categories.name) LIKE :search_query OR
                                LOWER(mini_categories.name) LIKE :search_query',
                                search_query: search_query)

      render json: MicroCategorySerializer.new(@micro_categories).serializable_hash, status: :ok
    end

    private

    def load_category
      @category = Category.find_by(id: params[:id])

      if @category.nil?
        render json: {
            message: "Category doesn't exists"
        }, status: :not_found
      end
    end

  end
end

