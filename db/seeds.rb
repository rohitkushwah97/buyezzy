# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

AdminUser.create!(email: 'admin@byezzy.com', password: 'password', password_confirmation: 'password') unless AdminUser.find_by(email: 'admin@byezzy.com')

# BxBlockCategories::BuildCategories.call

# if AccountBlock::Account.where(user_type: nil).present?
# 	AccountBlock::Account.where(user_type: nil).update_all(user_type: 'seller')
# end

['header_group_1','middle_group_1','middle_group_2','footer_group_1'].each do |group|
	BxBlockDashboard::BannerGroup.create(group_name: group)
end

# BxBlockShoppingCart::Order.where(order_number: nil).delete_all


statuses = ['scheduled','on_going','completed','cancelled', 'ordered', 'shipped', 'delivered']

BxBlockOrderManagement::OrderStatus.where(name: statuses).each do |order_status|
  order_status.update(name: order_status.name.capitalize.gsub('_',' '))
end

['Rejected', 'Processing', 'Scheduled','On going','Completed','Cancelled', 'Ordered', 'Shipped', 'Delivered', 'Started', 'Pickup Initiated', 'Received', 'QC Processing', 'QC Passed', 'QC Failed', 'Refund Initiated', 'Return', 'Refunded'].each do |status|
	BxBlockOrderManagement::OrderStatus.find_or_create_by(name: status)
end

# Creating seller header and footer pages

header = { title: ['Welcome to ByEzzy!','Features', 'Why us?', 'Pricing'], section: 'header' }
content = "No content available. Please provide content."

header[:title].each do |page_title|
	page = BxBlockTermsandconditions::SellerStaticPage.find_by(title: page_title)
	BxBlockTermsandconditions::SellerStaticPage.create(title: page_title, content: content, section: header[:section]) unless page
end

footer = { title: ['Privacy notice','Terms of service','Cost & Commission details',"Beginner's guide",'Fulfillment by ByEzzy','Fulfillment by Partner','Advertise on ByEzzy','Brand store'], section: 'footer' }
footer[:title].each do |page_title|
	page = BxBlockTermsandconditions::SellerStaticPage.find_by(title: page_title)
	BxBlockTermsandconditions::SellerStaticPage.create(title: page_title, content: content, section: footer[:section]) unless page
end

['Features', 'Pricing', 'Cost & Commission details',"Beginner's guide",'Fulfillment by ByEzzy','Advertise on ByEzzy','Brand store'].each do |page_title|
	page = BxBlockSupport::SupportDocument.find_by(page_title: page_title)
	BxBlockSupport::SupportDocument.create(page_title: page_title, content: content) unless page
end

['Terms and Conditions', 'Privacy Policy'].each do |page_title|
	page = BxBlockTermsandconditions::TermsPolicy.find_by(page_title: page_title)
	BxBlockTermsandconditions::TermsPolicy.create(page_title: page_title, content: content) unless page
end

['Tax Policy', 'Legal Policy'].each do |page_title|
	page = BxBlockTermsandconditions::PrivacyAndLegalPolicy.find_by(title: page_title)
	BxBlockTermsandconditions::PrivacyAndLegalPolicy.create(title: page_title, content: content) unless page
end

socials = {"Facebook" => "https://www.facebook.com/", "Instagram" => "https://www.instagram.com/", "LinkedIn" => "https://www.linkedin.com/", "TikTok" => "https://www.tiktok.com/", "YouTube" => "https://youtube.com/" }

socials.each do |social_media, social_media_url|
	page = BxBlockSupport::SocialPlatform.find_by(social_media: social_media)
	BxBlockSupport::SocialPlatform.create(social_media: social_media, social_media_url: social_media_url) unless page
end

["About us", "Testimonials", "Contact", "Privacy Policy", "Support", "Terms & Conditions", "Shipping & Returns"].each do |page_title|
	page = BxBlockSupport::StaticPage.find_by(title: page_title)
	BxBlockSupport::StaticPage.create(title: page_title, content: content) unless page
end

BxBlockDashboard::Banner.find_or_create_by(title: "Free shipping on all UAE orders AED 200", button_text: "SHOP NOW",banner_type: "top_banner", button_link: ENV["FE_URL"])