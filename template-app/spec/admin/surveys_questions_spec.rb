require 'rails_helper'

RSpec.describe Admin::SurveysQuestionsController, type: :controller do
  render_views
  
  before(:each) do
    admin = FactoryBot.create(:admin)
    sign_in admin
  end

  let!(:industry)  { create(:industry) }
  let!(:role)  { create(:role) }
  let!(:intern_characteristic) { create(:intern_characteristic) }
  let!(:survey) { create(:survey) }
  let!(:version) { create(:version, name: "Version 1", survey_id: survey.id) }
  let!(:question) { create(:question, default_weight: 100, intern_characteristic_id: intern_characteristic.id, business_question: "sfdsd", intern_question: "fsds",  version_id: version.id, survey_id: survey.id)}
  let!(:options1) {create(:option, name: "opt1", question_id: question.id)}
  let!(:options2) {create(:option, name: "opt2", question_id: question.id)}
  let!(:options3) {create(:option, name: "opt3", question_id: question.id)}
  let!(:options4) {create(:option, name: "opt4", question_id: question.id)}
  let!(:options5) {create(:option, name: "opt5", question_id: question.id)}

  describe 'GET#index' do
    context 'get all role name' do
      it 'should return list of role' do
        get :index
        expect(response).to have_http_status(302)
        expect(response.message).to eql('Found')
        expect(response.body).to be_present
      end
    end
  end

  describe 'GET#Questions' do
    context 'get version questions' do
      it 'should return questions' do
        get :questions, params: {id: survey.id, version_id: version.id}
        expect(response).to have_http_status(200)
        expect(response.body).to be_present
      end
    end
  end

  describe 'GET#survey_index' do
    context 'get all surveys' do
      it 'should return surveys list' do
        get :survey_index
        expect(response).to have_http_status(200)
        expect(response.body).to be_present
      end
    end
  end

  describe 'GET#show' do
    context 'get single survey' do
      it 'should return survey name' do
        get :show, params: { id: survey.id }
        expect(response).to have_http_status(200)
        expect(response.body).to be_present
      end
    end
  end

  describe "Get#Edit" do
    it "edit Survey" do
      patch :edit, params: {
        id: survey.id,
        survey: {
          questions_attributes: {
            "0" => {
              default_weight: 100,
              intern_characteristic_id: intern_characteristic.id,
              business_question: "xyz",
              intern_question: "abc",
              options_attributes: {
                "0" => { name: "o1" },
                "1" => { name: "o2" },
                "2" => { name: "o3" },
                "3" => { name: "o4" },
                "4" => { name: "o5" }
              }
            }
          }
        }
      }
      expect(response).to have_http_status(200)
      expect(response.body).to be_present
    end

    it "update Survey" do
      patch :update, params: {
        id: survey.id,
        survey: {
          questions_attributes: {
            "0" => {
              default_weight: 100,
              intern_characteristic_id: intern_characteristic.id,
              business_question: "xyz",
              intern_question: "abc",
              options_attributes: {
                "0" => { name: "o1" },
                "1" => { name: "o2" },
                "2" => { name: "o3" },
                "3" => { name: "o4" },
                "4" => { name: "o5" }
              }
            }
          }
        }
      }
      expect(response).to have_http_status(302)
      expect(response.body).to be_present
    end

    it "update question with options of Survey" do
      patch :update, params: {
        id: survey.id,
        survey: {
          questions_attributes: {
            "0" => {
              "default_weight": "100",
              "business_question": "xyz",
              "intern_question": "abc",
              "id": "#{question.id}",
              "options_attributes": {
              "0" => {
                "name": "cop1",
                "id": "#{options2.id}"
              },

              "1" => {
                "name": "cop1",
                "id": "#{options2.id}"
              },

              "2" => {
                "name": "cop1",
                "id": "#{options2.id}"
              },

             "3" => {
                "name": "cop1",
                "id": "#{options2.id}"
              },

              "4" => {
                "name": "cop1",
                "id": "#{options2.id}"
              }
            }
          },
            
          }
        }
      }
      expect(response).to have_http_status(302)
      expect(response.body).to be_present
    end
  end
end
