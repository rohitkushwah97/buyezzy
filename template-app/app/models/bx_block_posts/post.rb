module BxBlockPosts
  class Post < BxBlockPosts::ApplicationRecord
    self.table_name = :posts
    ActiveSupport.run_load_hooks(:post, self)
    require 'profanity_filter'
    has_many_attached :images
    has_many_attached :image_thumbnails
    has_many_attached :video_thumbnails

    validate :check_profanity

    if ENV['TEMPLATEAPP_DATABASE']
      include PublicActivity::Model
      tracked owner: proc { |controller, _| controller&.current_user }
    end
    IMAGE_CONTENT_TYPES = %w(image/jpg image/jpeg image/png)

    has_many_attached :images, dependent: :destroy

    belongs_to :category,
               class_name: 'BxBlockCategories::Category', optional: true

    # belongs_to :sub_category,
    #            class_name: 'BxBlockCategories::SubCategory',
    #            foreign_key: :sub_category_id, optional: true

    belongs_to :account, class_name: 'AccountBlock::Account'
    has_many_attached :media, dependent: :destroy

    # validates_presence_of :body
    validates :media,
    size: { between: 1..3.megabytes }, content_type: IMAGE_CONTENT_TYPES

    private

    def check_profanity
      return if body.blank?
      profane_words = find_profanity(body)
      restricted_words = BxBlockLikeAPost::RestrictedWord.all.pluck(:word)

      used_restricted_words = restricted_words.select { |word| body.include?(word) }
      all_inappropriate_words = (profane_words + used_restricted_words).uniq
      if all_inappropriate_words.any?
        errors.add(:body, "contains inappropriate content: #{all_inappropriate_words.join(', ')}")
      end
    end

    def find_profanity(text)
      words_in_text = text.downcase.scan(/\w+/) # Extract words from text
      words_in_text.select { |word| ProfanityFilter::Base.profane?(word) } # Check each word
    end
  end
end
