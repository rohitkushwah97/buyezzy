require 'rails_helper'
 
RSpec.describe Admin::VersionsController, type: :controller do
  render_views
  
  before(:each) do
    admin =  FactoryBot.create(:admin)
    sign_in admin
  end

  let!(:industry)  {create(:industry)}
  let!(:role)  {create(:role)}
  let!(:intern_characteristic) {create(:intern_characteristic)}
  let!(:survey) {create(:survey)}
  let!(:version) { create(:version)}
  let!(:question) {create(:question, survey_id: survey.id, version_id: version.id)}

  describe 'GET#form' do
    context 'can get qeustions form' do
      it 'should able to get questions of survey form' do
        get :new , params: {id: version.id}
        expect(response).to have_http_status(200)
        expect(response.body).to be_present
      end
    end
  end

  describe 'PUT#update' do
    context 'can update, destroy, add questions' do
      it 'should able to update questions of version' do
        get :update , params: {id: version.id, version: {id: version.id, question_id: question.id, questions_attributes: {"1"=>{intern_characteristic_id: intern_characteristic.id, business_question: "business_question", intern_question: "intern_question", default_weight: 98, options_attributes: {"0"=>{name: "ans1"},"1"=>{name: "ans2"}, "2"=>{name: "ans3"}, "3"=>{name: "ans4"}, "4"=>{name: "ans5"}}}}}}
        expect(response).to have_http_status(302)
        expect(response.message).to eq("Found")
      end
    end

    context 'can update previous question' do
      let!(:question) {create(:question, version_id: version.id, survey_id: survey.id)}
      it 'should not create new version' do
        get :update , params: {id: version.id, version: {id: version.id, questions_attributes: {"1"=>{intern_characteristic_id: intern_characteristic.id, business_question: question.business_question, intern_question: question.intern_question, default_weight: 98, id: question.id, _destroy: "0", options_attributes: {"0"=>{name: "ans1"},"1"=>{name: "ans2"}, "2"=>{name: "ans3"}, "3"=>{name: "ans4"}, "4"=>{name: "ans5"}}}}}}
        expect(response).to have_http_status(302)
        expect(response.message).to eq("Found")
      end
    end

    let!(:question) {create(:question, version_id: version.id, survey_id: survey.id)}
      it 'should not create new version' do
        get :update , params: {id: version.id, version: {id: version.id, questions_attributes: {"1"=>{intern_characteristic_id: intern_characteristic.id, business_question: question.business_question, intern_question: question.intern_question, default_weight: 98, id: question.id, _destroy: "1", options_attributes: {"0"=>{name: "ans1"},"1"=>{name: "ans2"}, "2"=>{name: "ans3"}, "3"=>{name: "ans4"}, "4"=>{name: "ans5"}}}}}}
        expect(response).to have_http_status(302)
        expect(response.message).to eq("Found")
      end

    context 'not create new version' do
      it 'should not able to create and edit questions' do
        get :update , params: {id: version.id, version: {id: version.id, questions_attributes: {"1"=>{intern_characteristic_id: intern_characteristic.id, business_question: "question1", intern_question: "question1", default_weight: 78, id: question.id, _destroy: "0", options_attributes: {"0"=>{name: "ans1"},"1"=>{name: "ans2"}, "2"=>{name: "ans3"}, "3"=>{name: "ans4"}, "4"=>{name: "ans5"}}}}}}
        expect(response).to have_http_status(302)
        expect(response.message).to eq("Found")
      end
    end

    context 'validation fails of default weight ' do
      it 'should not able to create and edit questions' do
        get :update , params: {id: version.id, version: {id: version.id, question_id: question.id, questions_attributes: {"1"=>{intern_characteristic_id: intern_characteristic.id, business_question: "business_question", intern_question: "intern_question", default_weight: 105, options_attributes: {"0"=>{name: "ans1"},"1"=>{name: "ans2"}, "2"=>{name: "ans3"}, "3"=>{name: "ans4"}, "4"=>{name: "ans5"}}}}}}
        expect(response).to have_http_status(302)
        expect(response.message).to eq("Found")
      end
    end

    context 'validation fails of business and intern questions ' do
      it 'should not able update if business and intern blank' do
        get :update , params: {id: version.id, version: {id: version.id, question_id: question.id, questions_attributes: {"1"=>{intern_characteristic_id: intern_characteristic.id, default_weight: 10, options_attributes: {"0"=>{name: "ans1"},"1"=>{name: "ans2"}, "2"=>{name: "ans3"}, "3"=>{name: "ans4"}, "4"=>{name: "ans5"}}}}}}
        expect(response).to have_http_status(302)
        expect(response.message).to eq("Found")
      end
    end

    context 'validation fails of options not equal to 5' do
      it 'should not update if options count is not 5' do
        get :update , params: {id: version.id, version: {id: version.id, question_id: question.id, questions_attributes: {"1"=>{intern_characteristic_id: intern_characteristic.id, default_weight: 99,business_question: "business_question", intern_question: "intern_question", options_attributes: {"0"=>{name: "ans1"},"1"=>{name: "ans2"}, "2"=>{name: "ans3"}, "3"=>{name: "ans4"}}}}}}
        expect(response).to have_http_status(302)
        expect(response.message).to eq("Found")
      end
    end

    context 'validation fails of any option field is blank' do
      it 'should not update if any option field blank' do
        get :update , params: {id: version.id, version: {id: version.id, question_id: question.id, questions_attributes: {"1"=>{intern_characteristic_id: intern_characteristic.id, default_weight: 69,business_question: "business_question", intern_question: "intern_question", options_attributes: {"0"=>{name: "ans1"},"1"=>{name: "ans2"}, "2"=>{name: "ans3"}, "3"=>{name: ""}, "4"=>{name: ""}}}}}}
        expect(response).to have_http_status(302)
        expect(response.message).to eq("Found")
      end
    end
  end

end
