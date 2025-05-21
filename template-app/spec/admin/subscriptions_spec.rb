require 'rails_helper'

RSpec.describe Admin::SubscriptionsController, type: :controller do
  render_views

  PLAN_TITLE = "Monthly Plan".freeze
  PLAN_AMOUNT = 199

  before(:each) do
    @admin = FactoryBot.create(:admin)
    sign_in @admin
  end

  let!(:subscription) { BxBlockSubscriptionBilling::Subscription.create!(title: PLAN_TITLE, amount: PLAN_AMOUNT) }

  describe 'GET#index' do
    it 'indexing of subscription page successfully' do
      get :index
      expect(response).to have_http_status(200)
      expect(response.body).to include(PLAN_TITLE)
    end
  end

  describe 'GET#show' do
    it 'shows the subscription description' do
      get :show, params: { id: subscription.id }
      expect(response).to have_http_status(:ok)
      expect(response.body).to include(PLAN_TITLE)
      expect(response.body).to include(PLAN_AMOUNT.to_s)
    end
  end

  describe 'GET#edit' do
    it 'renders the edit subscription page' do
      get :edit, params: { id: subscription.id }
      expect(response).to have_http_status(:ok)
      expect(response.body).to include("Edit Subscription")
    end
  end

  describe 'PATCH#update' do
    it 'updates the subscription and redirects' do
      patch :update, params: {
        id: subscription.id,
        subscription: {
          title: "Updated Plan",
          amount: 299
        }
      }

      subscription.reload
      expect(subscription.title).to eq("Updated Plan")
      expect(subscription.amount).to eq(299)
      expect(response).to redirect_to(admin_subscription_path(subscription))
    end
  end
end
