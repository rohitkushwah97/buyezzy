require 'rails_helper'

RSpec.describe BxBlockSurveys::InternUserGenericAnswersController, type: :controller do
  let(:business_user) { FactoryBot.create(:business_user) }
  let(:business_token) { BuilderJsonWebToken.encode(business_user.id) }
  let(:intern_user) { FactoryBot.create(:intern_user) }
  let(:token) { BuilderJsonWebToken.encode(intern_user.id) }
  let(:internship) { FactoryBot.create(:bx_block_navmenu_internship, business_user_id: business_user.id) }
  let!(:questions) { FactoryBot.create(:intern_user_generic_question, internship: internship, business_user: business_user) }
  let!(:questions2) { FactoryBot.create(:intern_user_generic_question, internship: internship, business_user: business_user) }
  let(:answer) { FactoryBot.create(:intern_user_generic_answer, internship: internship, intern_user_generic_question_id: questions2.id, account_id: intern_user.id) }
  let(:json_response) { JSON.parse(response.body) }

  let(:valid_attributes) do
    {
      token: token,
      intern_user_generic_answers: [
      {
        answer: "My name is John Doe",
        intern_user_generic_question_id: questions.id
      }
    ],
     internship_id: internship.id
    }
  end

  let(:existing_answer_attributes) do
    {
      token: token,
      intern_user_generic_answers: [
      {
        answer: 'Updated Existing Answer',
        intern_user_generic_question_id: questions.id
      }
    ],
    internship_id: internship.id
    }
  end

  let(:invalid_attributes) do
    {
      token: token,
      intern_user_generic_answers: [
      {
        answer: "In the context of the ongoing debates and discussions surrounding the future of technological advancements, there are numerous aspects that must be considered when evaluating the impact that these advancements will have on different sectors of society, including but not limited to the economic, social, and environmental implications. From a broader perspective, it is essential to ask how the rapid pace of innovation, particularly in fields such as artificial intelligence, automation, and biotechnology, will influence the workforce, particularly in terms of job displacement, the creation of new job categories, and the overall structure of labor markets across both developed and developing countries. Furthermore, the potential ethical concerns related to the deployment of these technologies, especially in terms of privacy, surveillance, and data security, cannot be overlooked, as they raise important questions about how societies should balance the benefits of technological progress with the need to protect individual rights and freedoms. Additionally, there is the issue of access to these technologies, and whether their benefits will be equitably distributed across different populations or whether they will exacerbate existing inequalities, both within and between countries. For instance, how can policymakers ensure that marginalized communities, who may already face significant barriers to education, healthcare, and economic opportunity, are not left behind in the technological revolution? In light of these considerations, it is also necessary to explore how governments, international organizations, and the private sector can collaborate to establish regulatory frameworks that not only foster innovation but also ensure that its benefits are widely shared and that the risks are adequately mitigated. This raises additional questions about the role of public institutions in funding research and development, particularly in areas that may not yield immediate commercial returns but are nonetheless crucial for addressing long-term challenges, such as climate change, public health, and sustainable development. With respect to the environment, it is critical to examine how technological innovations can be leveraged to combat climate change, reduce greenhouse gas emissions, and promote more sustainable modes of production and consumption, while also taking into account the potential environmental costs associated with the extraction of raw materials, the generation of electronic waste, and the energy consumption required to power the digital economy. Moreover, the intersection of technology and geopolitics cannot be ignored, as the global race for technological supremacy, particularly in areas such as 5G, artificial intelligence, and quantum computing, is likely to shape the balance of power between nations in the coming decades. How should countries navigate the tensions between cooperation and competition in the realm of technological development, and what mechanisms can be put in place to prevent technological advancements from becoming a source of conflict or exacerbating existing geopolitical rivalries? Finally, it is important to consider how individuals can be better prepared to navigate the challenges and opportunities presented by technological change, whether through educational reforms that emphasize critical thinking, creativity, and adaptability, or through lifelong learning initiatives that help workers continually update their skills in response to shifting demands in the labor market. In conclusion, the future of technological progress is full of both promise and uncertainty, and the questions that arise in its wake are both complex and multifaceted.
          QUESTION",
        intern_user_generic_question_id: questions.id
      }
    ],
    internship_id: internship.id
    }
  end

  describe 'POST #create' do
    CREATE_MESSAGE = 'Internship applied successfully.'
    context 'with valid params' do
      it 'creates a new InternUserGenericAnswer' do
        post :create, params: valid_attributes
        expect(response).to have_http_status(:ok)
        expect(json_response["message"]).to eq(CREATE_MESSAGE)
      end
    end

    it 'updates the existing answer' do
      intern_user.intern_user_generic_answers.create(internship_id: internship.id , intern_user_generic_question_id: questions.id ,answer: "test answer")
      post :create, params: existing_answer_attributes
      expect(response).to have_http_status(:ok)
      expect(json_response["message"]).to eq(CREATE_MESSAGE)
    end

    context 'with invalid params' do
      it 'does not create a new InternUserGenericAnswer and returns errors' do
        post :create, params: invalid_attributes
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)["error"]).to eq("Validation failed: Answer must be 500 characters or fewer")
      end
    end
  end

  describe 'GET #generic_answers_and_questions' do
    it 'get InternUserGenericAnswer' do
      answer
      get :generic_answers_and_questions, params: {token: business_token,intern_user_id: intern_user.id,internship_id:internship.id}
      expect(response).to have_http_status(:ok)
      expect(json_response['data'][0]['attributes']['question']['id']).to eq(questions2.id)
    end

     it 'if not get InternUserGenericAnswer' do
      get :generic_answers_and_questions, params: {token: business_token, internship_id:internship.id,intern_user_id: intern_user.id}
      expect(response).to have_http_status(:not_found)
      expect(json_response['data']).to eql([])
    end
  end
end

