module BxBlockLogin
  class LoginsController < ApplicationController
    skip_before_action :validate_json_web_token, :authenticate_account, except: [:logout]
    
    def create
      case params[:data][:type] #### rescue invalid API format
      when 'email_account'
        account = OpenStruct.new(jsonapi_deserialize(params))
        account.type = params[:data][:type]

        output = AccountAdapter.new
        device_id = params[:device_id]

        output.on(:account_not_found) do |account|
          render json: {
            errors: [{
              failed_login: 'Account does not exist.',
            }],
          }, status: :unprocessable_entity
        end

        output.on(:account_not_activated) do |account|
          render json: {
            errors: [{
              failed_login: 'Account is not active.',
            }],
          }, status: :unprocessable_entity
        end

        output.on(:failed_login) do |account|
          render json: {
            errors: [{
              failed_login: "Password doesn't match.",
            }],
          }, status: :unauthorized
        end

        output.on(:successful_login) do |account, token, refresh_token|
          return render json: { failed_login: "Account is blocked. Please contact admin."}, status: :unauthorized if account.is_blacklisted
          if params[:device_id].present?
            current_device_ids = account.device_id || []            
            unless current_device_ids.include?(params[:device_id])
              account.update(
                device_id: current_device_ids + [params[:device_id]], 
                activated: true
              )
            end
          end

          if is_business_user?(account)
            company_detail = account.company_detail
            is_profile_updated = company_details_present?(company_detail)
          else
            is_profile_updated = false
          end

          render json: {
            meta: {
              token: token,
              refresh_token: refresh_token,
              id: account.id,
              type: account.type,
              is_profile_updated: is_profile_updated
            }
          }
        end

        output.login_account(account)
      else
        render json: {
          errors: [{
            account: 'Invalid Account Type',
          }],
        }, status: :unprocessable_entity
      end
    end

    def is_business_user?(account)
      account.type == "BusinessUser"
    end

    def logout
      if @current_user
        if params[:device_id].present? && @current_user.device_id.present?
          @current_user.update(
            device_id: @current_user.device_id - [params[:device_id]]
          )
        end

       current_token = request.headers[:token] || params[:token]
    
        if current_token.present?
          current_expire_tokens = @current_user.invalid_tokens || []
          @current_user.update(invalid_tokens: current_expire_tokens << current_token)
        end
        
        render json: { message: "Logged out successfully" }, status: :ok
      else
        render json: { error: "Not authenticated" }, status: :unauthorized
      end
    end

    def company_details_present?(company_detail)
      company_detail.present? &&
      company_detail.company_name.present? &&
      company_detail.website_link.present? &&
      company_detail.contact_number.present?
    end
  end
end
