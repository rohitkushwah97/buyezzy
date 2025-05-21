module BxBlockSeoSetting
  class SeoSettingSerializer < BuilderBase::BaseSerializer
  	attributes *[
        :id,
        :page_name, 
        :meta_title, 
        :meta_description,
        :created_at,
        :updated_at
    ]
  end
end