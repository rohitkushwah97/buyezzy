module BxBlockStoreManagement
  class StoreDashboardSectionsController < ApplicationController
    before_action :validate_json_web_token, except: [:index, :show]
    before_action :set_store
    before_action :set_store_dashboard_section, only: [:show, :update, :destroy]

    def index
      @store_dashboard_sections = @store.store_dashboard_sections.all.order(created_at: :asc)

      render json: StoreDashboardSectionSerializer.new(@store_dashboard_sections), status: :ok
    end

    def show
      render json: StoreDashboardSectionSerializer.new(@store_dashboard_section).serializable_hash, status: :ok
    end

    def create
      @store_dashboard_section = StoreDashboardSection.new(store_dashboard_section_params.merge(store_id: @store&.id))

      if @store_dashboard_section.save
        render json: StoreDashboardSectionSerializer.new(@store_dashboard_section).serializable_hash, status: :created
      else
        render json: {
          errors: format_activerecord_errors(@store_dashboard_section.errors) }, status: :unprocessable_entity
      end
    end

    def update
      if @store_dashboard_section.update(store_dashboard_section_params.merge(store_id: @store&.id))
        render json: StoreDashboardSectionSerializer.new(@store_dashboard_section).serializable_hash, status: :ok
      else
        render json: {
          errors: format_activerecord_errors(@store_dashboard_section.errors)}, status: :unprocessable_entity
      end
    end

    def destroy
      if @store_dashboard_section.destroy
        render json: {message: "Section removed"}, status: :ok
      end
    end

    private

    def store_dashboard_section_params
      params.permit(:section_name, :section_type, :banner_name, :banner_image, :banner_url, store_section_grids_attributes: [:id, :grid_name, :grid_no, :grid_image, :grid_url, :_destroy])
    end

    def set_store
      @store = Store.find(params[:store_id])
    end

    def set_store_dashboard_section
      @store_dashboard_section = @store.store_dashboard_sections.find_by(id: params[:id])
      if @store_dashboard_section.nil?
        render json: {
          message: "Section not found"
        }, status: :not_found
      end
    end
  end
end