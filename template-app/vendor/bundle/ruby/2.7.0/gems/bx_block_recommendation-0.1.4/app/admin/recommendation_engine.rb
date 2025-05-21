module RecommendationEngine
end

ActiveAdmin.register BxBlockRecommendation::CatalogueRecommend, as:'CatalogueRecommends' do

	permit_params :recommendation_setting, :value

  form do |f|
    f.inputs do
      f.input :recommendation_setting
      f.input :value
    end
    f.actions
  end

  show do
    attributes_table do
      row :recommendation_setting
      row :value
    end
  end
end  
