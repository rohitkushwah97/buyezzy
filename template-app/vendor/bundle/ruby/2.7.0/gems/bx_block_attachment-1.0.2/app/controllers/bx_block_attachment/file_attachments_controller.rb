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

module BxBlockAttachment
  class FileAttachmentsController < ApplicationController
    include BuilderJsonWebToken::JsonWebTokenValidation
    include ActiveStorage::SetCurrent
    before_action :validate_json_web_token

    def index
      @file_attachments = BxBlockAttachment::FileAttachment.where(created_by: @token.id).all
      render json: { date: FileAttachmentSerializer.new(@file_attachments).serializable_hash }, status: :ok
    end

    def create
      @file_attachment = BxBlockAttachment::FileAttachment.new(file_attachment_params)
      @file_attachment.created_by = @token.id
      if @file_attachment.save

        render json: { data: FileAttachmentSerializer.new(@file_attachment).serializable_hash }, status: :created
      else
        render json: { errors: @file_attachment.errors.full_messages }, status: :unprocessable_entity
      end
    end

    def destroy
      file_attachment = BxBlockAttachment::FileAttachment.find_by(id: params[:id], created_by: @token.id)
      unless file_attachment.present?
        return render json: {
          errors: [
            { message: 'File Attachment does not exist.' }
          ]
        }, status: :unprocessable_entity
      end
      if file_attachment.destroy
        render json: { message: 'File Attachment deleted.' }, status: :ok
      else
        render json: BxBlockAttachment::ErrorSerializer.new(file_attachment), status: :unprocessable_entity

      end
    end

    def update
      file_attachment = BxBlockAttachment::FileAttachment.find_by(id: params[:id], created_by: @token.id)

      return render json: { errors: 'File Attachment not found' }, status: :not_found if file_attachment.blank?

      if file_attachment.update(file_attachment_params)

        render json: { data: FileAttachmentSerializer.new(file_attachment).serializable_hash }, status: :ok
      else
        render json: { errors: file_attachment.errors.full_messages }, status: :bad_request

      end
    end

    private

    def file_attachment_params
      params[:attachment] = params[:url]
      params.permit(:name, :description, :embeded_code, :url, :tag, :content_type, :thumnail, :is_active,
                    :updated_by, :created_by, :attachment)
    end
  end
end
