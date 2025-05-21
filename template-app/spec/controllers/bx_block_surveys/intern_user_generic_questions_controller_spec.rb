require 'rails_helper'

RSpec.describe BxBlockSurveys::InternUserGenericQuestionsController, type: :controller do
  business_user = FactoryBot.create(:business_user)
  let(:token) { BuilderJsonWebToken.encode(business_user.id) }
  intern_user = FactoryBot.create(:intern_user, email: Faker::Internet.unique.email(name: nil, separators: '.', domain: 'gmail.com'))
  let(:intern_token) { BuilderJsonWebToken.encode(intern_user.id) }

  QUESTION = "In the context of the ongoing debates and discussions surrounding the future of technological advancements, there are numerous aspects that must be considered when evaluating the impact that these advancements will have on different sectors of society, including but not limited to the economic, social, and environmental implications. From a broader perspective, it is essential to ask how the rapid pace of innovation, particularly in fields such as artificial intelligence, automation, and biotechnology, will influence the workforce, particularly in terms of job displacement, the creation of new job categories, and the overall structure of labor markets across both developed and developing countries. Furthermore, the potential ethical concerns related to the deployment of these technologies, especially in terms of privacy, surveillance, and data security, cannot be overlooked, as they raise important questions about how societies should balance the benefits of technological progress with the need to protect individual rights and freedoms. Additionally, there is the issue of access to these technologies, and whether their benefits will be equitably distributed across different populations or whether they will exacerbate existing inequalities, both within and between countries. For instance, how can policymakers ensure that marginalized communities, who may already face significant barriers to education, healthcare, and economic opportunity, are not left behind in the technological revolution? In light of these considerations, it is also necessary to explore how governments, international organizations, and the private sector can collaborate to establish regulatory frameworks that not only foster innovation but also ensure that its benefits are widely shared and that the risks are adequately mitigated. This raises additional questions about the role of public institutions in funding research and development, particularly in areas that may not yield immediate commercial returns but are nonetheless crucial for addressing long-term challenges, such as climate change, public health, and sustainable development. With respect to the environment, it is critical to examine how technological innovations can be leveraged to combat climate change, reduce greenhouse gas emissions, and promote more sustainable modes of production and consumption, while also taking into account the potential environmental costs associated with the extraction of raw materials, the generation of electronic waste, and the energy consumption required to power the digital economy. Moreover, the intersection of technology and geopolitics cannot be ignored, as the global race for technological supremacy, particularly in areas such as 5G, artificial intelligence, and quantum computing, is likely to shape the balance of power between nations in the coming decades. How should countries navigate the tensions between cooperation and competition in the realm of technological development, and what mechanisms can be put in place to prevent technological advancements from becoming a source of conflict or exacerbating existing geopolitical rivalries? Finally, it is important to consider how individuals can be better prepared to navigate the challenges and opportunities presented by technological change, whether through educational reforms that emphasize critical thinking, creativity, and adaptability, or through lifelong learning initiatives that help workers continually update their skills in response to shifting demands in the labor market. In conclusion, the future of technological progress is full of both promise and uncertainty, and the questions that arise in its wake are both complex and multifaceted.
  QUESTION"
  FIRSTQUESTION = "What is your name?"

  let(:valid_attributes) do
    {
      token: token,
      intern_user_generic_questions: 
      [
        {
          action_type: 'delete',
          data: [intern_user_generic_question.id]
        },
        {
          action_type: 'update',
          data: [
            {
              id: intern_user_generic_question2.id,
              question: "question 4?"
            }
          ]
        },
        {
          action_type: 'create',
          internship_id: internship.id,
          data: [
            {
              question: "question 2?"
            }
          ]
        }
      ]
    }
  end

  let(:intern_valid_attributes) do
    {
      token: intern_token,
      intern_user_generic_questions: [
        {
          question: "What is your surname?",
          internship_id: internship.id
        }
      ]
    }
  end

  let(:create_delete_invalid_attributes) do
    {
      token: token,
      intern_user_generic_questions: 
      [
        {
          action_type: 'delete',
          data: [0]
        }
      ]
    }
  end

  let(:internship) { FactoryBot.create(:bx_block_navmenu_internship, business_user_id: business_user.id) }
  let(:intern_user_generic_question) { FactoryBot.create(:intern_user_generic_question, internship: internship, business_user: business_user) }
  let(:intern_user_generic_question2) { FactoryBot.create(:intern_user_generic_question, internship: internship, business_user: business_user) }
  let(:intern_user_generic_questions) { FactoryBot.create_list(:intern_user_generic_question,3, internship: internship, business_user: business_user) }
  let(:json_response) { JSON.parse(response.body) }

   describe 'GET #dummy_trigger_exception' do
    it 'get dummy_trigger_exception' do
      get :dummy_trigger_exception
      expect(response).to have_http_status(:internal_server_error)
      expect(json_response['error']).to eq('server is not working')
    end
  end

  describe 'GET #index' do
    it 'get all InternUserGenericQuestion' do
      intern_user_generic_question
      get :index, params:{token: intern_token,internship_id:internship.id}
      expect(response).to have_http_status(:ok)
      expect(json_response['data'][0]['id'].to_i).to eq(intern_user_generic_question.id)
    end

    it 'InternUserGenericQuestion is not present for internship' do
      get :index, params:{token: intern_token,internship_id:internship.id}
      expect(response).to have_http_status(:not_found)
      expect(json_response['data']).to eql([])
    end
  end

  describe 'POST #create' do
    it 'creates a new InternUserGenericQuestion' do
      post :create, params: valid_attributes
      expect(response).to have_http_status(:created)
      expect(json_response['message']).to eq('Extra questions added successfully.')
    end

    it 'question is not created' do
      post :create, params: { token: token, intern_user_generic_questions: [{ action_type: 'create', internship_id: internship.id, data: [ { question: QUESTION } ] }]}
      expect(response).to have_http_status( :unprocessable_entity)
      expect(json_response['error']).to eq('Validation failed: Question must be 100 characters or fewer')
    end

    it 'Maximum 3 question is created for one internship' do
      intern_user_generic_questions
      post :create, params: valid_attributes
      expect(response).to have_http_status( :unprocessable_entity)
      expect(json_response['error']).to eq('Validation failed: You can only create up to 3 Generic Question for one internship.')
    end

    it 'invalid params' do
      post :create, params: create_delete_invalid_attributes
      expect(response).to have_http_status( :unprocessable_entity)
      expect(json_response['error']).to eq("Couldn't find BxBlockSurveys::InternUserGenericQuestion with 'id'=0")
    end
  end

  describe 'private methods' do
    describe '#find_business_user' do
      it 'renders error when user is not a business user' do
        get :create, params: intern_valid_attributes
        expect(JSON.parse(response.body)["error"]).to eq('invalid user, account should be business account')
      end
    end
  end

  describe 'GET #intern_user_generic_questions' do
    context 'when there are generic questions' do
      let!(:questions) { create_list(:intern_user_generic_question, 3) }
      before do
        get :intern_user_generic_questions
      end
      it 'returns a successful response' do
        # expect(response).to have_http_status(:ok)
      end
    end
  end

  describe 'GET #get_applicants' do
    context 'when the internship exists' do
      let!(:internship) { create(:bx_block_navmenu_internship) }
      let!(:accounts) { create_list(:account, 3, internships: [internship]) }
      before do
        get :get_applicants, params: { id: internship.id }
      end
      it 'returns a successful response' do
        # expect(response).to have_http_status(:ok)
      end
    end
  end
end
