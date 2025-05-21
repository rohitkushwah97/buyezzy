# frozen_string_literal: true
# Protected Area Start
# Copyright (c) 2024 Engineer.ai Corp. (d/b/a Builder.ai). All rights reserved.
#  *
# This software and related documentation are proprietary to Builder.ai.
# This software is furnished under a license agreement and/or a nondisclosure
# agreement and may be used or copied only in accordance with the terms of such
# agreements. Unauthorized copying, distribution, or other use of this software
# or its documentation is strictly prohibited.
#  *
# This software: (1) was developed at private expense and no part of it was
# developed with government funds, (2) is a trade secret of Builder.ai for all
# purposes of the Freedom of Information Act, (3) is "commercial computer
# software" subject to limited utilization as provided in the contract between
# Builder.ai and its licensees, and (4) in all respects is proprietary data
# belonging solely to Builder.ai.
#  *
# For inquiries regarding licensing, please contact: legal@builder.ai
# Protected Area End

module BxBlockAnalytics
  class AnalyticsEventsController < BxBlockAnalytics::ApplicationController
    def create
      raise ::BxBlockAnalytics::MissingEventName if event_params["name"].blank?

      BxBlockAnalytics::PublishEvent.call(
        event_name: event_params["name"],
        identifier: current_user.id,
        properties: event_params["properties"].to_h
      )
      render status: :no_content
    rescue ::BxBlockAnalytics::MissingEventName => e
      render json: {errors: [analytics_event: e.message]}, status: :unprocessable_entity
    rescue JWT::DecodeError, JWT::ExpiredSignature, ActiveRecord::RecordNotFound
      render json: {errors: [analytics_event: "Unauthorised"]}, status: :unauthorized
    end

    private

    def event_params
      params.require(:analytics_event).permit(
        :name,
        properties: {}
      )
    end
  end
end
