module AccountBlock
  class City < ApplicationRecord
    self.table_name = :cities
    belongs_to :country
    validates_presence_of :name
    validates :name, uniqueness: {scope: :country_id, case_sensitive: false }
  end
end
