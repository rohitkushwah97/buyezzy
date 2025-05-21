require 'rails_helper'

RSpec.describe AccountBlock::SellerDocument, type: :model do

  let(:document) {  [fixture_file_upload(Rails.root.join("spec", "fixtures", "files", "document.pdf"))] }

  describe "associations" do
    it { should belong_to(:account).class_name("AccountBlock::Account") }
    it { should have_many_attached(:document_files) }
  end

  describe "custom validations" do
    context "when document type is vat_certificate and document_files are not attached" do
      let(:seller_document) { build(:seller_document, document_type: "VAT Certificate or Reason for not having it") }

      it "should validate presence of vat_reason" do
        expect(seller_document).to validate_presence_of(:vat_reason)
      end

      it "should set vat_reason to nil before update if vat_document_present?" do
        seller_document.save

        expect {
          seller_document.update(document_files: document)
        }.to change { seller_document.vat_reason }.to(nil)
      end
    end

    context "when document type is iban_certificate and document_files are attached" do
      let(:seller_document) { build(:seller_document, document_type: "IBAN Certificate or Bank Details", document_files: document) }

      it "should not validate presence of account_no, iban, bank_address, name, bank_name, and swift_code" do
        expect(seller_document).not_to validate_presence_of(:account_no)
        expect(seller_document).not_to validate_presence_of(:iban)
        expect(seller_document).not_to validate_presence_of(:bank_address)
        expect(seller_document).not_to validate_presence_of(:name)
        expect(seller_document).not_to validate_presence_of(:bank_name)
        expect(seller_document).not_to validate_presence_of(:swift_code)
      end

      it "should set account_no, iban, bank_address, name, bank_name, and swift_code to nil before update if iban_document_present?" do
        seller_document.save 
        expect {
          seller_document.update(document_files: document) 
        }.to change { [seller_document.account_no, seller_document.iban, seller_document.bank_address, seller_document.name, seller_document.bank_name, seller_document.swift_code] }.to([nil, nil, nil, nil, nil, nil])
      end

    end
  end
end
