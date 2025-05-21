require 'rails_helper'

RSpec.describe BxBlockCatalogue::Warehouse, type: :model do
	 subject(:warehouse) { FactoryBot.build(:warehouse) }
  # it { is_expected.to validate_presence_of(:warehouse_type) }
  it { is_expected.to validate_presence_of(:warehouse_name) }
  # it { is_expected.to validate_presence_of(:warehouse_address) }

describe 'should have has_many association' do
	# it { should have_many(:catalogues).class_name('BxBlockCatalogue::Catalogue') }
	it { should belong_to(:account).class_name('AccountBlock::Account').optional(true) }

end
end
