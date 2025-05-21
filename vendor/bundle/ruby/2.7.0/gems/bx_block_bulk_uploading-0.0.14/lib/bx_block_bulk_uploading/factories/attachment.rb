# frozen_string_literal: true

FactoryBot.define do
  factory :attachment, class: "BxBlockBulkUploading::Attachment" do
    colour { "red" }
    layout { " testing" }
    page_size { "3" }
    files do
      [Rack::Test::UploadedFile.new(BxBlockBulkUploading::Engine.root.join("spec/support/unit/image_test_new.jpg"),
        "image/jpeg")]
    end
    is_expired { false }
    is_printed { false }
    pdf_url { "pdf_url" }
    scale { "test" }
    print_sides { "print_sides" }
    print_pages_from { 1 }
    print_pages_to { 3 }
    total_pages { 3 }
    total_attachment_pages { 3 }
  end
end
