module BxBlockSurveys
  class ContactInternSerializer < BuilderBase::BaseSerializer
    attributes :id,:decision

    attribute :intern_user do |object,params|
     AccountBlock::InternUserSerializer.new(object.intern_user,params:{internship: params[:internship]}) 
    end
  end
end
