require 'rails_helper'

RSpec.describe BxBlockStoreManagement::StoreMenu, type: :model do
  let(:store) { create(:store) }

  context 'validations' do
    it 'validates presence of title when store_name is not present' do
      menu = build(:store_menu, store: store, title: nil, store_name: nil)
      expect(menu).not_to be_valid
      expect(menu.errors[:title]).to include("can't be blank")
    end

    it 'validates cover_image presence when store_name is present' do
      menu = build(:store_menu, store: store, store_name: 'Sample Store Name')
      expect(menu).not_to be_valid
      expect(menu.errors[:cover_image]).to include("must be attached when store name is present")
      expect(menu.errors[:logo]).to include("must be attached when store name is present")
    end

    it 'is valid when title is present and store_name is not present' do
      menu = build(:store_menu, store: store, title: 'Sample Title')
      expect(menu).to be_valid
    end

    it 'is valid when cover_image and logo are attached and store_name is present' do
      menu = build(:store_menu, store: store, store_name: 'Sample Store Name', cover_image: fixture_file_upload(Rails.root.join("spec", "fixtures", "files", "Sample.jpg")), logo: fixture_file_upload(Rails.root.join("spec", "fixtures", "files", "Sample.jpg")))
      expect(menu).to be_valid
    end
  end
end
