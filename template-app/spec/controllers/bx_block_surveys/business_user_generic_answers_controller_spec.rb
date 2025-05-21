require 'rails_helper'

RSpec.describe BxBlockSurveys::BusinessUserGenericAnswersController, type: :controller do
  business_user =  FactoryBot.create(:business_user)
  internship = FactoryBot.create(:bx_block_navmenu_internship, business_user_id: business_user.id)
  questions = FactoryBot.create(:business_user_generic_question)
  questions2 = FactoryBot.create(:business_user_generic_question)
  generic_answer = FactoryBot.create(:business_user_generic_answer, business_user: business_user, internship: internship, business_user_generic_question: questions)
  token = BuilderJsonWebToken.encode(business_user.id)

  ANSWER = "In the context of the ongoing debates and discussions surrounding the future of technological advancements, there are numerous aspects that must be considered when evaluating the impact that these advancements will have on different sectors of society, including but not limited to the economic, social, and environmental implications. From a broader perspective, it is essential to ask how the rapid pace of innovation, particularly in fields such as artificial intelligence, automation, and biotechnology, will influence the workforce, particularly in terms of job displacement, the creation of new job categories, and the overall structure of labor markets across both developed and developing countries. Furthermore, the potential ethical concerns related to the deployment of these technologies, especially in terms of privacy, surveillance, and data security, cannot be overlooked, as they raise important questions about how societies should balance the benefits of technological progress with the need to protect individual rights and freedoms. Additionally, there is the issue of access to these technologies, and whether their benefits will be equitably distributed across different populations or whether they will exacerbate existing inequalities, both within and between countries. For instance, how can policymakers ensure that marginalized communities, who may already face significant barriers to education, healthcare, and economic opportunity, are not left behind in the technological revolution? In light of these considerations, it is also necessary to explore how governments, international organizations, and the private sector can collaborate to establish regulatory frameworks that not only foster innovation but also ensure that its benefits are widely shared and that the risks are adequately mitigated. This raises additional questions about the role of public institutions in funding research and development, particularly in areas that may not yield immediate commercial returns but are nonetheless crucial for addressing long-term challenges, such as climate change, public health, and sustainable development. With respect to the environment, it is critical to examine how technological innovations can be leveraged to combat climate change, reduce greenhouse gas emissions, and promote more sustainable modes of production and consumption, while also taking into account the potential environmental costs associated with the extraction of raw materials, the generation of electronic waste, and the energy consumption required to power the digital economy. Moreover, the intersection of technology and geopolitics cannot be ignored, as the global race for technological supremacy"

  describe 'POST #create' do
    let(:valid_attributes) do
      {
        token: token,
        business_user_generic_answer: {
          answer: 'Answer 1',
          business_user_generic_question_id: questions2.id,
          internship_id: internship.id
        }
      }
    end
    let(:existing_answer_attributes) do
      {
        token: token,
        business_user_generic_answer: {
          answer: 'Updated Existing Answer',
          business_user_generic_question_id: questions.id,
          internship_id: internship.id
        }
      }
    end
    let(:invalid_attributes) do
      {
        token: token,
        business_user_generic_answer: {
          answer: ANSWER,
          business_user_generic_question_id: questions.id,
          internship_id: internship.id
        }
      }
    end

    it 'creates a new business user generic answer with valid attributes' do
      post :create, params: valid_attributes
      expect(response).to have_http_status(:created)
      expect(json_response['data']['answer']).to eq('Answer 1')
    end

    
    it 'updates the existing answer' do
      post :create, params: existing_answer_attributes
      expect(response).to have_http_status(:ok)
      expect(json_response['data']['answer']).to eq('Updated Existing Answer')
    end
  

    it 'fails to create a new answer with invalid attributes' do
      post :create, params: invalid_attributes
      expect(response).to have_http_status(:unprocessable_entity)
      expect(json_response['error'][0]).to include("Answer must be 100 characters or fewer")
    end
  end

  describe 'GET #index' do
    it 'get answerwitj questions' do
      get :index, params: {internship_id: internship.id, token: token}
      expect(response).to have_http_status(:ok)
      expect(json_response['data'][0]['attributes']['id']).to eq(generic_answer.id)
    end
  end
end
