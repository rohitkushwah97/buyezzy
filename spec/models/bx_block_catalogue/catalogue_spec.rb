# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BxBlockCatalogue::Catalogue, type: :model do
  describe 'should have has_one association' do
    it { should have_one(:barcode).class_name('BxBlockCatalogue::Barcode').dependent(:destroy) }
  end

  describe 'should have has_many association' do
    it { should have_many(:coupon_codes).through(:subscribe_coupons).class_name('BxBlockCouponCg::CouponCode') }
    it { should have_many(:subscribe_coupons).class_name('BxBlockCouponCg::SubscribeCoupon').dependent(:destroy) }
    it { should have_many(:review_and_ratings).class_name('BxBlockCatalogue::Review').dependent(:destroy) }
  end

  describe 'callbacks' do
    let(:category) { create(:category) }
    let(:sub_category) { create(:sub_category, category: category) }
    let(:mini_category) { create(:mini_category, sub_category: sub_category) }
    let(:micro_category) { create(:micro_category, mini_category: mini_category) }
    let(:custom_field_1) { create(:custom_field, field_name: 'Custom Field 1', fieldable: category) }
    let(:custom_field_2) { create(:custom_field, field_name: 'Custom Field 2', fieldable: sub_category) }
    let(:custom_field_3) { create(:custom_field, field_name: 'Custom Field 3', fieldable: mini_category) }
    let(:custom_field_4) { create(:custom_field, field_name: 'Custom Field 4', fieldable: micro_category) }
    let(:catalogue) { create(:catalogue, category: category, sub_category: sub_category, mini_category: mini_category, micro_category: micro_category, content_status: 'approved', status: true) }
    let(:field_name) {"Updated Field Name"}

    before do
      [custom_field_1, custom_field_2, custom_field_3, custom_field_4]
    end

    it 'creates catalogue contents for associated custom fields' do
 

      expect(catalogue.catalogue_contents.pluck(:custom_field_id)).to contain_exactly(custom_field_1.id, custom_field_2.id, custom_field_3.id, custom_field_4.id)
      expect(catalogue.catalogue_contents.pluck(:custom_field_name)).to contain_exactly(custom_field_1.field_name, custom_field_2.field_name, custom_field_3.field_name, custom_field_4.field_name)
    end

    it 'updates custom_field_name if it has changed' do
    	custom_field_2.update(field_name: field_name)

    	expect {
    		catalogue.update_attributes(sku: '123SKU456')
    	}
    	expect(catalogue.catalogue_contents.find_by(custom_field_id: custom_field_2.id).custom_field_name).to eq(field_name)

    end

    it 'updates archived status' do
      catalogue.content_status = 'archived'
      catalogue.save
      expect(catalogue.status).to eq(false)
    end

    it { should validate_presence_of(:sku) }

    it 'validates sku format' do
      valid_sku = "ABC#123-_.{}[]()/"
      invalid_sku = "ABCDw"

      catalogue.sku = valid_sku
      expect(catalogue).to be_valid

      catalogue.sku = invalid_sku
      expect(catalogue).to_not be_valid
      expect(catalogue.errors[:sku]).to include("should be alphanumeric and special characters")
    end

  end

end
