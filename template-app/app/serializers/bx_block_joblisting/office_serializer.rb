module BxBlockJoblisting
  class OfficeSerializer < BuilderBase::BaseSerializer
    attributes(:id, :company_page_id, :city, :state, :country)
  end
end
