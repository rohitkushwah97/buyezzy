ActiveAdmin.register BxBlockSurveys::BusinessUserGenericQuestion, as: 'Generic Questions' do

  permit_params :question, :title
  actions :index, :show, :edit, :update
  remove_filter :business_user_generic_answers
  
end
