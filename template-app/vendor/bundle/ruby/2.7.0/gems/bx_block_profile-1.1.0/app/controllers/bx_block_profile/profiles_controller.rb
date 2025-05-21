# frozen_string_literal: true

module BxBlockProfile
  class ProfilesController < ApplicationController
  
    def create
      profile = BxBlockProfile::Profile.create(profile_params.merge({account_id: current_user.id}))

      if profile.save
        render json: BxBlockProfile::ProfileSerializer.new(profile).serializable_hash, status: :created
      else
        render json: {
          errors: format_activerecord_errors(profile.errors)
        }, status: :unprocessable_entity
      end
    end

    def show
      profile = BxBlockProfile::Profile.find(params[:id])
      if profile.present?
        render json: ProfileSerializer.new(profile).serializable_hash, status: :ok
      else
        render json: {
          errors: format_activerecord_errors(profile.errors)
        }, status: :unprocessable_entity
      end
    end

    def update
      status, result = UpdateAccountCommand.execute(@token.id, update_params)
      if status == :ok
        serializer = AccountBlock::AccountSerializer.new(result)
        render json: serializer.serializable_hash,
          status: :ok
      else
        render json: {errors: [{profile: result.first}]},
          status: status
      end
    end

    def destroy
      profile = BxBlockProfile::Profile.find(params[:id])
      if profile.present?
        if profile.account_id == current_user.id
          profile.destroy
          render json: {message: 'Profile Removed'}, status: :ok
        else
          render json: {message: 'Profile do not exist for logged-in user'}, status: :unauthorized
        end
      else
        render json: {meta: {message: 'Record not found.'}}
      end
    end

    def update_profile
      profile = BxBlockProfile::Profile.find(params[:id])
      if profile.present?
        if profile.account_id == current_user.id
          profile.update(profile_params)
          render json: ProfileSerializer.new(profile, meta: {
            message: 'Profile Updated Successfully'
          }).serializable_hash, status: :ok
        else
          render json: {message: 'Profile do not exist for logged-in user'}, status: :unauthorized
        end
      end
    end

    private

    def current_user
      @account = AccountBlock::Account.find_by(id: @token.id)
    end

    def profile_params
      params.require(:profile).permit(:id, :country, :address, :city, :postal_code, photo: {})
    end

    def update_params
      params.require(:data).permit \
        :first_name,
        :last_name,
        :current_password,
        :new_password,
        :new_email,
        :new_phone_number
    end
  end
end
# rubocop:enable Style/Documentation, Metrics/MethodLength
