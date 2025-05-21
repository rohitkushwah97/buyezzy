require 'openai'
token = Rails.env.test? ? 'sk-proj-S0yFCIJQfVTaAZ6V4a7K1tKzSJ6JkarUMNuquvaTHYUGCZudlNYOX-4IZAyzmYFxvPApdnv2aPT3BlbkFJHm2FzIIAeNUdbDOoCc2FRaczCniijfQQsDX2GBKwP-pQp5atLU76wsEN_V3cmIEBtG2h6RzGEAy' : ENV['OPENAI_API_KEY']

OpenAI.configure do |config|
  config.access_token = token
end

OpenAIClient = OpenAI::Client.new(api_key: token)