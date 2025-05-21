module BxBlockCategories
  class CustomFieldsController < ApplicationController
    before_action :load_category, only: [:index,:show_custom_fields]
    before_action :load_category_or_micro_category, only: [:show_custom_fields]

    def index
      @custom_fields = CustomField.all

      render json: CustomFieldSerializer.new(@custom_fields).serializable_hash, status: :ok
    end

    def show_custom_fields
      custom_fields = []

      if @category
        custom_fields.concat(@category.custom_fields)
      end

      if @micro_category
        custom_fields.concat(@micro_category.custom_fields)
      end

      if custom_fields.empty?
        render json: {
          message: "Custom fields don't exist for this category or microcategory."
        }, status: :not_found
      else
        render json: CustomFieldSerializer.new(custom_fields).serializable_hash, status: :ok
      end
    end


    private

    def load_category
      @category = Category.find_by(id: params[:category_id])
    end

    def load_category_or_micro_category
      @micro_category = @category.micro_categories.find_by(id: params[:micro_category_id])
    end
  end
end
