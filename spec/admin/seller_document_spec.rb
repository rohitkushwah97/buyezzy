require 'rails_helper'

RSpec.describe Admin::SellerDocumentsController, type: :controller do
  render_views
  before do
    @admin = FactoryBot.create(:admin_user)
    @seller = FactoryBot.create(:account, user_type: 'seller')
    sign_in @admin
    doc_name = "document.pdf"
    @seller_document = create(:seller_document,document_files: [fixture_file_upload(Rails.root.join("spec", "fixtures", "files", doc_name))], account: @seller)
    @seller_documents = AccountBlock::SellerDocument.all
    @seller2 = FactoryBot.create(:account, user_type: 'seller')
    @seller_document1 = create(:seller_document,document_files: [fixture_file_upload(Rails.root.join("spec", "fixtures", "files", doc_name))], account: @seller2)
    @seller_document2 = create(:seller_document,document_files: [fixture_file_upload(Rails.root.join("spec", "fixtures", "files", doc_name))], account: @seller2, approved: true)
    @seller_document3 = create(:seller_document,document_files: [fixture_file_upload(Rails.root.join("spec", "fixtures", "files", doc_name))], account: @seller2, approved: true)
    @seller_document4 = create(:seller_document,document_files: [fixture_file_upload(Rails.root.join("spec", "fixtures", "files", doc_name))], account: @seller2, approved: true)
    @seller_document5 = create(:seller_document,document_files: [fixture_file_upload(Rails.root.join("spec", "fixtures", "files", doc_name))], account: @seller2, approved: true)
  end

  describe 'GET index' do
    it 'renders the index template' do
      get :index
      expect(response).to render_template(:index)
    end

    it 'assigns all seller documents to @seller_documents' do
      get :index
      expect(assigns(:seller_documents)).to match_array(@seller_documents)
    end
  end

  describe 'GET show' do

    it 'renders the show template' do
      get :show, params: { id: @seller_document.id }
      expect(response).to render_template(:show)
    end

    it 'assigns the requested seller document to @seller_document' do
      get :show, params: { id: @seller_document.id }
      expect(assigns(:seller_document)).to eq(@seller_document)
    end
  end

  describe 'POST update' do

    it 'updates the seller document with approved status' do
      post :update, params: { id: @seller_document1.id, seller_document: { approved: true } }
      @seller_document1.reload
      expect(@seller_document1.approved).to eq(true)
      expect(ActionMailer::Base.deliveries.count).to eq(1)
    end

    it 'updates the seller document with rejected status' do
      post :update, params: { id: @seller_document.id, seller_document: { rejected: true, approved: false } }
      @seller_document.reload
      expect(@seller_document.rejected).to eq(true)
      expect(@seller_document.approved).to eq(false)
      expect(ActionMailer::Base.deliveries.count).to eq(1)
    end

    it 'updates the seller document with reason for rejection' do
      post :update, params: { id: @seller_document.id, seller_document: { reason_for_rejection: 'Invalid document' } }
      @seller_document.reload
      expect(@seller_document.reason_for_rejection).to eq('Invalid document')
    end

    describe 'POST update_approved' do
      it 'updates the seller document and redirects to admin_account_path' do
        post :update, params: { id: @seller_document.id, seller_document: { rejected: '1' } }
        expect(response).to redirect_to(admin_seller_account_path(@seller_document.account))
        expect(flash[:notice]).to eq('Document updated successfully.')
        expect(@seller_document.reload.approved).to eq(false)
      end

      it 'updates the seller document and renders the edit template' do
        post :update, params: { id: @seller_document.id, seller_document: { rejected: true, approved: true} }
        expect(flash[:error]).to eq("Only one status can be selected: either 'approved' or 'rejected', but not both.")
      end
    end

  end
end