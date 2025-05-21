module BxBlockStoreManagement
  class StoreSectionGridsController < ApplicationController
    before_action :validate_json_web_token
    before_action :set_store
    before_action :set_store_dashboard_section
    before_action :set_store_section_grid, only: [:show, :update, :destroy]

    def index
      @store_section_grids = @store_dashboard_section.store_section_grids.all.order(created_at: :asc)

      render json: StoreSectionGridSerializer.new(@store_section_grids), status: :ok
    end

    def show
      render json: StoreSectionGridSerializer.new(@store_section_grid).serializable_hash, status: :ok
    end

    def create
      @store_section_grid = StoreSectionGrid.new(store_section_grid_params.merge(store_dashboard_section_id: @store_dashboard_section&.id))

      if @store_section_grid.save
        render json: StoreSectionGridSerializer.new(@store_section_grid).serializable_hash, status: :created
      else
        render json: {
          errors: format_activerecord_errors(@store_section_grid.errors)}, status: :unprocessable_entity
      end
    end

    def update
      if @store_section_grid.update(store_section_grid_params.merge(store_dashboard_section_id: @store_dashboard_section&.id))
        render json: StoreSectionGridSerializer.new(@store_section_grid).serializable_hash, status: :ok
      else
        render json: {
          errors: format_activerecord_errors(@store_section_grid.errors)}, status: :unprocessable_entity
      end
    end

    def destroy
      if @store_section_grid.destroy
        render json: {message: "Grid removed"}, status: :ok
      end
    end

    private

    def store_section_grid_params
      params.permit( :grid_name, :grid_no, :grid_image, :grid_url)
    end

    def set_store
      @store = Store.find(params[:store_id])
    end

    def set_store_dashboard_section
      @store_dashboard_section = @store.store_dashboard_sections.find_by(id: params[:store_dashboard_section_id])
      if @store_dashboard_section.nil?
        render json: {
          message: "Section not found"
        }, status: :not_found
      end
    end

    def set_store_section_grid
      @store_section_grid = @store_dashboard_section.store_section_grids.find_by(id: params[:id])
      if @store_section_grid.nil?
        render json: {
          message: "Grid not found"
        }, status: :not_found
      end
    end
  end
end