ActiveAdmin.register BxBlockDashboard::MostPopularCategory, as: 'Most Popular Category' do
  menu parent: 'Home Page'
  permit_params :sequence_no, :category_id


end
