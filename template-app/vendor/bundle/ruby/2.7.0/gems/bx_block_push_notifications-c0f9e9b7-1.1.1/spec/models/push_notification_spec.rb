require 'rails_helper'

RSpec.describe BxBlockPushNotifications::PushNotification, type: :model do

  before(:all) do
    @push_notificable = create(:account)
    @user = create(:account)
  end

  let(:valid_attributes) {
    attributes_for(:push_notification )
  }

  it "should belongs to an push notificable" do
    t = BxBlockPushNotifications::PushNotification.reflect_on_association(:push_notificable)
    expect(t.macro).to eq(:belongs_to)
  end

  it "should belongs to an account" do
    t = BxBlockPushNotifications::PushNotification.reflect_on_association(:account)
    expect(t.macro).to eq(:belongs_to)
  end

  it "is valid with valid attributes" do
    valid_attributes[:account_id] = @user.id
    valid_attributes[:push_notificable] =@push_notificable
    notification = BxBlockPushNotifications::PushNotification.new(valid_attributes)
    expect(@push_notificable).to be_valid
  end

  it "is not valid without a remarks" do
    valid_attributes[:account_id] = @user.id
    valid_attributes[:push_notificable] =@user
    valid_attributes[:remarks] = nil
    push_notification = BxBlockPushNotifications::PushNotification.new(valid_attributes)
    expect(push_notification).not_to be_valid
  end

  it "is not valid without a account" do
    valid_attributes[:push_notificable] =@push_notificable
    push_notification = BxBlockPushNotifications::PushNotification.new(valid_attributes)
    expect(push_notification).not_to be_valid
  end

  it "is not valid without a push notificable" do
    valid_attributes[:account_id] = @user.id
    push_notification = BxBlockPushNotifications::PushNotification.new(valid_attributes)
    expect(push_notification).not_to be_valid
  end

end
