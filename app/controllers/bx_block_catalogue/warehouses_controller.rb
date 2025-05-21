module BxBlockCatalogue
  class WarehousesController < ApplicationController
  before_action :set_warehouse, only: [:update_seller_warehouse, :delete_seller_warehouse]
  before_action :validate_json_web_token, only: [:create_seller_warehouse, :update_seller_warehouse, :delete_seller_warehouse, :seller_warehouse_listing]
  before_action :get_account, only: [:create_seller_warehouse, :update_seller_warehouse, :delete_seller_warehouse, :seller_warehouse_listing]
  before_action :check_seller_user, only: [:create_seller_warehouse,:update_seller_warehouse, :delete_seller_warehouse, :seller_warehouse_listing]

  def index
    @warehouses = Warehouse.all
    render json: @warehouses
  end

  def show
   @warehouse = Warehouse.find(params[:id])
   render json: @warehouse
  end

  def create
    @warehouse = Warehouse.new(warehouse_params)

    if @warehouse.save
      render json: @warehouse, status: :created
    else
      render json: @warehouse.errors, status: :unprocessable_entity
    end
  end

  def seller_warehouse_listing
    render json: WarehouseSerializer.new(@account.warehouses), status: :ok
  end

  def create_seller_warehouse    
    warehouse = @account.warehouses.new(warehouse_params)
    if warehouse.save
      render json: WarehouseSerializer.new(warehouse).serializable_hash, status: :created
    else
      render json: { errors: warehouse.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update_seller_warehouse
    if @warehouse.update(warehouse_params)
      catalogue_update_message = update_warehouse_catalogues(@warehouse, params[:warehouse][:catalogue_ids])
      render json: WarehouseSerializer.new(@warehouse).serializable_hash.merge(message: catalogue_update_message), status: :ok
    else
      render json: { errors: @warehouse.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def delete_seller_warehouse   
    if @warehouse.destroy
      render json: { message: 'Warehouse deleted successfully' }, status: :ok
    end
  end


  # def update
  #   if @warehouse.update(warehouse_params)
  #     render json: @warehouse
  #   else
  #     render json: @warehouse.errors, status: :unprocessable_entity
  #   end
  # end

  # def destroy
  #   @warehouse.destroy
  # end

  private
  
    def set_warehouse
      @warehouse = Warehouse.find_by(id: params[:warehouse][:id])
      if @warehouse.nil?
        render json: {
          message: "Warehouse with id #{params[:warehouse][:id]} doesn't exists"
        }, status: :not_found
      end
    end

    def warehouse_params
      params.require(:warehouse).permit(:warehouse_type, :warehouse_name, :warehouse_address_1,:warehouse_address_2, :contact_number, :contact_person, :processing_days)
    end

    def update_warehouse_catalogues(warehouse, catalogue_ids)
      return if catalogue_ids.nil?
    
      new_ids = catalogue_ids.map(&:to_i).to_set
      current_ids = warehouse.warehouse_catalogues.pluck(:catalogue_id).to_set
    
      to_add = new_ids - current_ids
      to_remove = current_ids - new_ids
    
      return { success: true } if to_add.empty? && to_remove.empty?
    
      WarehouseCatalogue.transaction do
        to_add.each do |id|
          warehouse.warehouse_catalogues.create!(catalogue_id: id, stocks: 5)
        end
        warehouse.warehouse_catalogues.where(catalogue_id: to_remove.to_a).destroy_all
      end
    
      { success: true }
    rescue ActiveRecord::RecordInvalid => e
      { success: false, error: e.message }
    end

  end
end
