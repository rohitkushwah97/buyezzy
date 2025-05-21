ActiveAdmin.register BxBlockDashboard::HeaderCategory, as: 'Header Categories' do
  menu parent: 'Home Page'
  permit_params :sequence_no, :category_id


end