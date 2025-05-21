require "spec_helper"
require "rails_helper"

RSpec.describe BxBlockAddress::Address, type: :model do
  # let (:subject) { build :bx_block_address/address }
  context "validation" do
    it { should validate_presence_of :address_type }
  end
  context "associations" do
    it { should belong_to :account }
  end
end
