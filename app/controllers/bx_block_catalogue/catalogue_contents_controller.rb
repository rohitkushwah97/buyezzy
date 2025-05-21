module BxBlockCatalogue
  class CatalogueContentsController < ApplicationController
    before_action :set_catalogue, except: [:fetch_custom_field_filters]

    def index
      catalogue_contents = @catalogue.catalogue_contents.order(created_at: :asc)

      render json: CatalogueContentSerializer.new(catalogue_contents).serializable_hash, status: :ok
    end

    def create
      content_entries = content_params
      saved_contents = []

      catalogue_contents = @catalogue.catalogue_contents.new(content_entries)

      catalogue_contents.each do |catalogue_content|
        if catalogue_content.save
          saved_contents << catalogue_content
        end
      end

      if saved_contents.any?
        render json: CatalogueContentSerializer.new(saved_contents).serializable_hash, status: :created
      else
        render json: { error: 'No valid content entries found' }, status: :unprocessable_entity
      end
    end

    def update_catalogue_contents
      content_entries = content_params

      updated_contents = []

      content_entries.each do |entry|
        content = CatalogueContent.find_by(id: entry[:id])

        if content && content.update(entry)
          updated_contents << content
        end
      end

      if updated_contents.any?
        render json: CatalogueContentSerializer.new(updated_contents).serializable_hash, status: :ok
      else
        render json: { error: 'No valid content entries found for update' }, status: :unprocessable_entity
      end
    end

    def delete_catalogue_contents
      @contents = CatalogueContent.where(id: params[:ids])
      if @contents.delete_all
        render json: { message: 'Catalogue Content removed' }, status: :ok
      end
    end

    def fetch_custom_field_filters
      category_ids = params[:category_ids]
      sub_category_ids = params[:sub_category_ids]
      mini_category_ids = params[:mini_category_ids]
      micro_category_ids = params[:micro_category_ids]

      custom_field_values = {}

      if category_ids.present? || sub_category_ids.present? || mini_category_ids.present? || micro_category_ids.present?
        custom_fields = BxBlockCategories::CustomField.includes(:fieldable)
                              .where(fieldable_type: ["BxBlockCategories::Category", "BxBlockCategories::SubCategory", "BxBlockCategories::MiniCategory", "BxBlockCategories::MicroCategory"],
                                     fieldable_id: [category_ids, sub_category_ids, mini_category_ids, micro_category_ids].flatten)

                              custom_fields.each do |custom_field|
                                values = BxBlockCatalogue::CatalogueContent.includes(:custom_field)
                                .where(custom_fields: { id: custom_field.id })
                                .pluck(:value)
                                .reject(&:blank?)
                                if values.present?
                                  custom_field_values[custom_field.field_name] ||= []
                                  custom_field_values[custom_field.field_name] += values
                                end
                              end
      end

      render json: { custom_field_values: custom_field_values }, status: :ok
    end

    private

    def set_catalogue
      @catalogue = Catalogue.find(params[:catalogue_id])
    end

    def content_params
      params.require(:catalogue_contents_entries).map do |entry|
        entry.permit(:id, :custom_field_id, :value, :custom_field_name)
      end
    end
  end
end
