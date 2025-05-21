module AccountBlock
  class BusinessUsersController < AccountBlock::ApplicationController
    before_action :validate_json_web_token, :authenticate_account, :business?, except: %i(create list_cities)

    def index 
      success_response(BusinessUser.all)
    end

    def create
      business_user = Account.find_by(email: params[:email])
      return render json: {message: "This email address is already taken. Please try another."} if business_user.present?
      business_user = BusinessUser.new(jsonapi_deserialize(params))
      if business_user.save
        AccountActivationMailer.with(account: business_user).activation_email.deliver_now!
        return success_response(business_user, :created)
      else
        return error_response(business_user)
      end
    end

    def show
      return success_response(@current_user)
    end

    def update
      photo = params[:company_detail_attributes]&.dig(:photo)
      if @current_user.update(input_params)
        generate_profile_thumbnail(@current_user.company_detail, photo) if photo.present?
        return success_response(@current_user)
      else
        return error_response(@current_user)
      end
    end

    def destroy
      return render json: {id: @current_user.id, message: "Business User deleted."},status: 200 if @current_user.destroy
    end

    def list_cities
      country = AccountBlock::Country.find_by(id: params[:country_id])
      if country
        cities = country.cities.pluck(:id, :name).map { |id, name| { id: id, name: name } }
        render json: { cities: cities }  
      else
        render json: [], status: :not_found
      end
    end

    private

    def generate_profile_thumbnail(current_user, file)
      require 'image_processing/mini_magick'
      thumbnail_tempfile = Tempfile.new(['thumb', '.jpg'], binmode: true)

      begin
        ImageProcessing::MiniMagick
          .source(file.tempfile)
          .resize_to_limit(300, 300)
          .call(destination: thumbnail_tempfile.path)

        thumbnail_tempfile.rewind

        current_user.photo_thumbnail.attach(
          io: thumbnail_tempfile,
          filename: "thumb_#{file.original_filename}.jpg",
          content_type: 'image/jpeg'
        )
      ensure
        thumbnail_tempfile.close!
        thumbnail_tempfile.unlink
      end
    end

    def input_params
      params.permit(:email, :password, company_detail_attributes: [:id, :company_name, :industry_id, :website_link, :contact_number, :country_id, :city_id, :country_code, :country_flag, :address, :company_description, :photo]
      )
    end

    def success_response(business_user, status = 200)
      res = BusinessUserSerializer.new(business_user).serializable_hash
      render json: res, status: status
    end

    def error_response(business_user)
      render json: {
        errors: format_activerecord_errors(business_user.errors)
      },
      status: :unprocessable_entity
    end
  end
end