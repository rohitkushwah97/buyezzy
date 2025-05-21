module BxBlockContactUs
  class Contact < BxBlockContactUs::ApplicationRecord
    self.table_name = :contacts
    has_many :admin_replies, class_name: "BxBlockContactUs::AdminReply", dependent: :destroy
    accepts_nested_attributes_for :admin_replies, allow_destroy: true
    validates :title, :email, :contact_type, :description , presence: true
    has_one_attached :image
    enum contact_type: { complaint: "complaint", feedback: "feedback", query: "query"}
  end
end
