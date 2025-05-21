module BxBlockCatalogue
  class WarehouseCataloguesController < ApplicationController
    include BxBlockCatalogue::CatalogueSearch
    before_action :validate_json_web_token, only: [:index, :show, :create, :update, :destroy]
    before_action :get_account, only: [:index, :show, :create, :update, :destroy]
    before_action :check_seller_user, only: [:index, :show, :create, :update, :destroy]
    before_action :set_warehouse
    before_action :find_warehouse_catalogue, only: [ :update, :show, :destroy]

    def index
      per_page = params[:per_page].presence&.to_i || 10
      page_number = params[:page].presence&.to_i || 1
      total_count = 0
      @warehouse_catalogues = @warehouse.warehouse_catalogues.all.order(created_at: :desc)     
      if params[:search_query].present?
        @warehouse_catalogues = @warehouse.warehouse_catalogues.includes(:catalogue)
                                          .includes(:product_variant_group)
                                          .where('LOWER(catalogues.sku) LIKE :query OR LOWER(product_variant_groups.product_sku) LIKE :query',query: "%#{params[:search_query]&.strip&.downcase}%").references(:catalogues).references(:product_variant_groups)
      end

      if @warehouse_catalogues.present?
        total_count = @warehouse_catalogues.count
        @warehouse_catalogues = paginate_catalogues(@warehouse_catalogues, page_number, per_page)
      end

      render json: WarehouseCatalogueSerializer.new(@warehouse_catalogues).serializable_hash.merge(total_count: total_count), status: :ok
    end

    def show
      render json: WarehouseCatalogueSerializer.new(@warehouse_catalogue).serializable_hash, status: :ok
    end

    def create
      @warehouse_catalogue = @warehouse.warehouse_catalogues.new(warehouse_catalogue_params)
      if @warehouse_catalogue.save
        render json: WarehouseCatalogueSerializer.new(@warehouse_catalogue).serializable_hash, status: :created
      else
        render json: { errors: @warehouse_catalogue.errors.full_messages }, status: :unprocessable_entity
      end
    end

    def update
      if @warehouse_catalogue.update(warehouse_catalogue_params)
        render json: WarehouseCatalogueSerializer.new(@warehouse_catalogue).serializable_hash, status: :ok
      else
        render json: { errors: @warehouse_catalogue.errors.full_messages }, status: :unprocessable_entity
      end
    end

    def destroy
      if @warehouse_catalogue.destroy
        render json: { message: 'Warehouse catalogue deleted successfully' }, status: :ok
      end
    end

    private

    def set_warehouse
      @warehouse = @account.warehouses.find(params[:warehouse_id]) unless @account.blank?
      render json: { error: 'Warehouse not found' },status: :not_found unless @warehouse.present?
    end

    def warehouse_catalogue_params
      params.require(:warehouse_catalogue).permit(:product_variant_group_id, :catalogue_id, :stocks)
    end

    def find_warehouse_catalogue
      @warehouse_catalogue = WarehouseCatalogue.find(params[:id])
    end
  end
end
