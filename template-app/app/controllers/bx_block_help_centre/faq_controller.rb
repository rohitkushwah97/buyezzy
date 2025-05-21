module BxBlockHelpCentre
  class FaqController < ApplicationController
    before_action :validate_json_web_token, :authenticate_account
    before_action :set_faq, only: [:show, :update, :destroy]

    def index
      faqs = BxBlockHelpCentre::Faq.all.order(created_at: :desc)
      render_with_faq_serializer(faqs)
    end

    def show
      render_with_faq_serializer(@faq)
    end

    def create
      @faq = BxBlockHelpCentre::Faq.new(faq_params)

      if @faq.save
        render_with_faq_serializer(@faq, :created)
      else
        render json: { errors: @faq.errors.full_messages }, status: :unprocessable_entity
      end
    end

    def update
      if @faq.update(faq_params)
        render_with_faq_serializer(@faq)
      else
        render json: { errors: @faq.errors.full_messages }, status: :unprocessable_entity
      end
    end

    def destroy
      if @faq.destroy
        render json: { message: 'FAQ deleted successfully' }, status: :ok
      else
        render json: { errors: @faq.errors.full_messages }, status: :unprocessable_entity
      end
    end

    def business_faq
      company_faqs = BxBlockHelpCentre::Faq.where(created_for: 'Business user').order(created_at: :desc)
      render_with_faq_serializer(company_faqs)
    end

    def intern_faq
      intern_faqs = BxBlockHelpCentre::Faq.where(created_for: 'Intern user').order(created_at: :desc)
      render_with_faq_serializer(intern_faqs)
    end

    def general_faq
      general_faq = BxBlockHelpCentre::Faq.where(created_for: 'General FAQ').order(created_at: :desc)
      render_with_faq_serializer(general_faq)
    end

    private

    def render_with_faq_serializer(object, status = 200)
      res = BxBlockHelpCentre::FaqSerializer.new(object).serializable_hash
      render json: res, status: status
    end

    def set_faq
      @faq = BxBlockHelpCentre::Faq.find(params[:id])
    end

    def faq_params
      params.require(:faq).permit(:question, :answer, :created_for)
    end
  end
end
