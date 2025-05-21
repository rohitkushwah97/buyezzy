# BxBuilderChain

This gem / building block allows builder apps to use open ai.
The following features are included:
  - OpenAi completion with GPT 3.5 and GPT 4
  - Q&A / additional prompt context with a users private documents
  - Documents can be stored on a global and user/group level

## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add bx_builder_chain

followed by

    $ bundle install

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install bx_builder_chain


### Setup

generate the endpoints & Active admin contollers for Builder Chain along with the DB migrations

    $ rails generate builder_chain:install

this will add the following endpoint controllers
 - File upload
 - List files
 - Delete file
 - OpenAi ask / completion
 - ActiveAdmin documents controller

It will also add a test view / controller for testing the endpoints. ensure this is removed prior to production release

## Usage
```ruby
require "bx_builder_chain"
```

edit the initializer config 'bx_builder_chain.rb' setup the api keys and db credentials
```
BxBuilderChain.configure do |config|
  config.openai_api_key = ENV['OPENAI_API_KEY']

  # for db use this
  config.pg_url = ENV['DB_URL'] || nil # eg 'postgres://postgres:password@localhost:5432/my_db'

  # or this - pg_url with take preference
  config.database_host = ENV['DB_HOSTNAME'] || 'localhost'
  config.database_name = ENV['DB_NAME']
  config.database_user = ENV['DB_USER']
  config.database_password = ENV['DB_PASSWORD']
  config.database_port = ENV['DB_PORT'] || '5432' # Defaulting to 5432 if not set

  config.public_namespace = "public"
  config.threshold = 0.25
  config.default_prompt_template = "Context information is below
  --------------------
  %{context}
  --------------------
  Given the context information and not prior knowledge
  answer the question: %{question}"
end
```

create the llm and client
```ruby
client = BxBuilderChain::Vectorsearch::Pgvector.new(
      llm: BxBuilderChain::Llm::OpenAi.new,
      namespace: user_id # default is nil, nil assumes global public documents
    )
```

Add documents to the Vector Store

```ruby
# Store plain texts in your vector search database
client.add_texts(
    texts: [
        "Begin by preheating your oven to 375°F (190°C). Prepare four boneless, skinless chicken breasts by cutting a pocket into the side of each breast, being careful not to cut all the way through. Season the chicken with salt and pepper to taste. In a large skillet, melt 2 tablespoons of unsalted butter over medium heat. Add 1 small diced onion and 2 minced garlic cloves, and cook until softened, about 3-4 minutes. Add 8 ounces of fresh spinach and cook until wilted, about 3 minutes. Remove the skillet from heat and let the mixture cool slightly.",
        "In a bowl, combine the spinach mixture with 4 ounces of softened cream cheese, 1/4 cup of grated Parmesan cheese, 1/4 cup of shredded mozzarella cheese, and 1/4 teaspoon of red pepper flakes. Mix until well combined. Stuff each chicken breast pocket with an equal amount of the spinach mixture. Seal the pocket with a toothpick if necessary. In the same skillet, heat 1 tablespoon of olive oil over medium-high heat. Add the stuffed chicken breasts and sear on each side for 3-4 minutes, or until golden brown."
    ]
)
```
```ruby
# Store the contents of your files in your vector search database
my_pdf = "path/to/my.pdf"
my_text = "path/to/my.txt"
my_docx = "path/to/my.docx"

client.add_data(paths: [my_pdf, my_text, my_docx])
```

Or via the service object
```ruby
my_pdf = "path/to/my.pdf"
my_text = "path/to/my.txt"
my_docx = "path/to/my.docx"

service = DocumentUploadService.new(
    files: [my_pdf, my_text, my_docx],
    user_groups: current_user_document_groups, # optional defaults to ['public'] an uses the first value to store the docs
    client_class_name: CLIENT_CLASS_NAME, # optional defaults to 'BxBuilderChain::Vectorsearch::Pgvector'
    llm_class_name: LLM_CLASS_NAME # optional defaults to 'BxBuilderChain::Llm::OpenAi'
)

result = service.upload_and_process
```

Then ask the question
```ruby
client.ask(question: "What is Frogger?")
```