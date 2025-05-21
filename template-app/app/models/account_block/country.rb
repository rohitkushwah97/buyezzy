module AccountBlock
  class Country < ApplicationRecord
    self.table_name = :countries
    has_many :cities, dependent: :destroy
    validates_presence_of :name
    validates :name, uniqueness: { case_sensitive: false }
  end
end
