require 'rails_helper'

RSpec.describe Admin::SellerAccountsController, type: :controller do
  render_views

  before do
    @admin = FactoryBot.create(:admin_user)
    sign_in @admin
    @account = create(:account, user_type: 'seller') 
  end

  describe 'GET index' do
    it 'renders the index template' do
      get :index
      expect(response).to render_template(:index)
      expect(response).to have_http_status(200)
      expect(response.body).to include(@account.email)
      expect(response.body).to include(@account.first_name)
      expect(response.body).to include(@account.last_name)
      expect(response.body).to include(@account.user_type)
      expect(response.body).to include(@account.full_phone_number)
      expect(response.body).to include(@account.activated.to_s)
      expect(response.body).to include(@account.created_at.strftime('%B %d, %Y %H:%M'))
      expect(response.body).to include(@account.updated_at.strftime('%B %d, %Y %H:%M'))
      expect(response.body).to include(@account.language)
    end

    context 'with filters' do
      it 'filters by first name' do
        get :index, params: { q: { first_name_cont: @account.first_name } }
        expect(assigns(:seller_accounts)).to include(@account)
      end

      it 'filters by last name' do
        get :index, params: { q: { last_name_cont: @account.last_name } }
        expect(assigns(:seller_accounts)).to include(@account)
      end

      it 'filters by full phone number' do
        get :index, params: { q: { full_phone_number_cont: @account.full_phone_number } }
        expect(assigns(:seller_accounts)).to include(@account)
      end

      it 'filters by email' do
        get :index, params: { q: { email_cont: @account.email } }
        expect(assigns(:seller_accounts)).to include(@account)
      end

      it 'filters by language' do
        get :index, params: { q: { language_eq: @account.language } }
        expect(assigns(:seller_accounts)).to include(@account)
      end

      it 'filters by activated' do
        get :index, params: { q: { activated_eq: @account.activated } }
        expect(assigns(:seller_accounts)).to include(@account)
      end

      it 'filters by created date range' do
        get :index, params: { q: { created_at_gteq: @account.created_at.strftime("%Y-%m-%d 00:00:00"), created_at_lteq: @account.created_at.strftime("%Y-%m-%d 23:59:59") } }
        expect(assigns(:seller_accounts)).to include(@account)
      end

      it 'filters by updated date range' do
        get :index, params: { q: { updated_at_gteq: @account.updated_at.strftime("%Y-%m-%d 00:00:00"), updated_at_lteq: @account.updated_at.strftime("%Y-%m-%d 23:59:59") } }
        expect(assigns(:seller_accounts)).to include(@account)
      end
    end
  end

  describe 'GET show' do
    # let(:account) { create(:account) }

    it 'renders the show template' do
      get :show, params: { id: @account.id }
      expect(response).to render_template(:show)
    end

    it 'assigns the requested account to @account' do
      get :show, params: { id: @account.id }
      expect(assigns(:seller_account)).to eq(@account)
    end

    it 'displays seller documents in the panel' do
      seller_document = create(:seller_document,document_files: [fixture_file_upload(Rails.root.join("spec", "fixtures", "files", "document.pdf"))], account: @account)
      get :show, params: { id: @account.id }
      expect(assigns(:seller_account).seller_documents.pluck(:document_type)).to include(seller_document.document_type)
      expect(assigns(:seller_account).seller_documents.pluck(:document_name)).to include(seller_document.document_name)
      expect(assigns(:seller_account).seller_documents.pluck(:approved)).to include(seller_document.approved)
      expect(assigns(:seller_account).seller_documents.pluck(:rejected)).to include(seller_document.rejected)
    end

  end

  describe 'DELETE destroy' do
    context 'when seller account has associated records' do
      before do
        @brand = FactoryBot.create(:brand, account: @account)
        @catalogue = FactoryBot.create(:catalogue, brand: @brand)
      end

      it 'does not delete the seller account and sets a flash alert' do
        expect {
          delete :destroy, params: { id: @account.id }
        }.not_to change(AccountBlock::Account, :count)
        expect(flash[:alert]).to eq("Cannot delete seller account. Please delete associated products and brands.")
        expect(response).to redirect_to(admin_seller_accounts_path)
      end
    end

    context 'when seller account has no associated records' do
      it 'deletes the seller account and sets a flash notice' do
        expect {
          delete :destroy, params: { id: @account.id }
        }.to change(AccountBlock::Account, :count).by(-1)
        expect(flash[:notice]).to eq("Seller account successfully deleted.")
        expect(response).to redirect_to(admin_seller_accounts_path)
      end
    end
  end

  describe 'GET new' do
    it 'renders the new template' do
      get :new
      expect(response).to render_template(:new)
    end
  end
end
