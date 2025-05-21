# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BxBlockProfileBio::ViewProfile, type: :model do
  account = AccountBlock::Account.create!(email: "tester@me.com", password: "pAssword!23", password_confirmation: "pAssword!23", first_name: "test", last_name: "test", activated: true)
  profile_bio = BxBlockProfileBio::ProfileBio.create!(height: '5.5', weight: '50', height_type: 'foot',weight_type: 'kg', body_type: 'Athletic', mother_tougue: 'Hindi', religion: 'Jain', zodiac: 'Taurus', marital_status: 'Married', smoking: 'No', drinking: 'No', looking_for:"Marriage", about_me: 'test', about_business: 'test', personality: ['Extrovert'], interests: ['Astronomy'], languages: %w[test01 test02 test03], account_id: account.id)

  let!(:view_profile) { BxBlockProfileBio::ViewProfile.create!(profile_bio_id: profile_bio.id, view_by_id: account.id) }
  describe 'associations' do
    it { should belong_to(:viewer).class_name("AccountBlock::Account") }
    it { should belong_to(:profile_bio).class_name("BxBlockProfileBio::ProfileBio") }
  end

  describe 'mutual_friend' do
    it "mutual_friend" do
      view_profiles = BxBlockProfileBio::ViewProfile.where(view_by_id: account.id)
      mutual_friend = BxBlockProfileBio::ViewProfile.mutual_friend(account.id, view_profiles)
      expect(mutual_friend).not_to be(nil)
    end
  end
end
