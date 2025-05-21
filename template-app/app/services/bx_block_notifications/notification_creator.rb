module BxBlockNotifications
  class NotificationCreator
    attr_accessor :created_by,
                  :headings,
                  :contents,
                  :account_id
                  
    def initialize(created_by, headings, contents, navigates_to = nil,match_type = nil)
      @created_by = created_by
      @headings = headings
      @contents = contents
      @account_id = created_by.id
      @navigates_to = navigates_to
      @match_type = match_type
    end

    def call
      @notification = BxBlockNotifications::Notification.create(
          created_by: @created_by,
          headings: @headings,
          contents: @contents,
          account_id: @account_id,
          navigates_to: @navigates_to,
          match_type: @match_type
      )
    end
  end
end
