module BxBlockOrderManagement
  class StockIntakesController < ApplicationController
    before_action :find_seller, only: [:index, :create, :update, :destroy]
    before_action :set_stock_intake, only: [:show, :update, :destroy]

    def index
      @stock_intakes = StockIntake.all.where(seller: @seller).order(created_at: :desc)
      
      render json: StockIntakeSerializer.new(@stock_intakes).serializable_hash
    end

    def show
      render json: StockIntakeSerializer.new(@stock_intake).serializable_hash
    end

    def create
      @stock_intake = StockIntake.new(stock_intake_params.merge(seller: @seller))

      if @stock_intake.save
        render json: StockIntakeSerializer.new(@stock_intake).serializable_hash, status: :created
      else
        render json: {errors: format_activerecord_errors(@stock_intake.errors)}, status: :unprocessable_entity
      end
    end

    def update
      if @stock_intake.update(stock_intake_params)
        render json: StockIntakeSerializer.new(@stock_intake).serializable_hash
      else
        render json: {errors: format_activerecord_errors(@stock_intake.errors)}, status: :unprocessable_entity
      end
    end

    def destroy
      if @stock_intake.destroy
        render json: {message: "Stock intake deleted succesfully!"}, status: :ok
      end
    end

    private

    def set_stock_intake
      @stock_intake = StockIntake.find(params[:id])
    end

    def stock_intake_params
      params.require(:stock_intake).permit(:catalogue_id, :stock_value, :stock_qty, :ship_date, :receiving_date)
    end

    def find_seller
      @seller = AccountBlock::Account.find_by(id: @token.id, user_type: 'seller')
      render json: {errors: 'Seller is invalid'} and return unless @seller
    end
  end
end