module BxBlockCatalogue
  class BarcodesController < ApplicationController
    before_action :set_catalogue
    before_action :set_barcode, only: [:show, :update]

    before_action :validate_json_web_token

    def index
      @barcodes = Barcode.all

      render json: @barcodes
    end

    def show
      render json: @barcode
    end

    def create
      @barcode = Barcode.new(barcode_params.merge(catalogue_id: @catalogue.id))

      if @barcode.save
        render json: @barcode, status: :created
      else
        render json: @barcode.errors, status: :unprocessable_entity
      end
    end

    def update
      if @barcode.update(barcode_params.merge(catalogue_id: @catalogue.id))
        render json: @barcode, status: :ok
      else
        render json: @barcode.errors, status: :unprocessable_entity
      end
    end

    private

    def set_barcode
      @barcode = @catalogue.barcode
      if @barcode.nil? || params[:id].to_i != @barcode.id
        render json: {
          message: "Barcode with id #{params[:id]} doesn't exist"
        }, status: :not_found
      end
    end

    def barcode_params
      params.require(:barcode).permit(:bar_code, :catalogue_id)
    end

    def set_catalogue
      @catalogue = Catalogue.find_by(id: params[:catalogue_id])
      if @catalogue.nil?
        render json: {
          message: "Catalogue with id #{params[:catalogue_id]} doesn't exists"
        }, status: :not_found
      end
    end
  end
end