# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BxBlockCategories::CustomField, type: :model do
  describe '#update_catalogue_contents_custom_field_name' do
  	let(:category) {create(:category)}
    let!(:custom_field) { create(:custom_field, field_name: 'Old Field Name',fieldable: category) }
    let(:catalogue) {create(:catalogue, category: category)}
    let(:field_name) {"New Field Name"}

    it 'updates the custom_field_name for associated catalogue_contents' do
      custom_field.update(field_name: field_name)

      expect(catalogue.catalogue_contents.first.custom_field_name).to eq(field_name)
    end

     it 'updates the custom_field_name for associated catalogue_contents' do
      custom_field_new = create(:custom_field, field_name: 'custom',fieldable: category)
      catalogue_1 = create(:catalogue, category: category)
      custom_field_new.catalogue_contents << catalogue_1.catalogue_contents

      expect { custom_field_new.update(field_name: "update field") }.to change { catalogue_1.catalogue_contents.first.custom_field_name }
    end
  end
end
