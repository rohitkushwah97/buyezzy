module BxBlockCatalogue
  class DealSerializer < BuilderBase::BaseSerializer
    
    attributes :id, :deal_name, :deal_code,:discount_type,:discount_value, :start_date, :end_date, :status, :created_at, :updated_at

  end
end
