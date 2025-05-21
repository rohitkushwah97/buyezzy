module BxBlockComments
  module PatchAccountBlockAssociations
    extend ActiveSupport::Concern

    included do
      has_many :comments, class_name: 'BxBlockComments::Comment',
      dependent: :destroy
      has_many_attached :images
    end

  end
end
