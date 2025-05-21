# frozen_string_literal: true
# Protected Area Start
# Copyright (c) 2024 Engineer.ai Corp. (d/b/a Builder.ai). All rights reserved.
#  *
# This software and related documentation are proprietary to Builder.ai.
# This software is furnished under a license agreement and/or a nondisclosure
# agreement and may be used or copied only in accordance with the terms of such
# agreements. Unauthorized copying, distribution, or other use of this software
# or its documentation is strictly prohibited.
#  *
# This software: (1) was developed at private expense and no part of it was
# developed with government funds, (2) is a trade secret of Builder.ai for all
# purposes of the Freedom of Information Act, (3) is "commercial computer
# software" subject to limited utilization as provided in the contract between
# Builder.ai and its licensees, and (4) in all respects is proprietary data
# belonging solely to Builder.ai.
#  *
# For inquiries regarding licensing, please contact: legal@builder.ai
# Protected Area End

require 'rails_helper'

RSpec.configure do |config|
  # Specify a root folder where Swagger JSON files are generated
  # NOTE: If you're using the rswag-api to serve API descriptions, you'll need
  # to ensure that it's configured to serve Swagger from the same folder
  config.swagger_root = Rails.root.join('swagger').to_s

  # Define one or more Swagger documents and provide global metadata for each one
  # When you run the 'rswag:specs:swaggerize' rake task, the complete Swagger will
  # be generated at the provided relative path under swagger_root
  # By default, the operations defined in spec files are added to the first
  # document below. You can override this behavior by adding a swagger_doc tag to the
  # the root example_group in your specs, e.g. describe '...', swagger_doc: 'v2/swagger.json'
  config.swagger_docs = {
    'v1/swagger.json' => {
      openapi: '3.0.1',
      info: {
        title: 'bx_block_attachment',
        version: '0.1.0'
      },
      paths: {},
      servers: [
        {
          url: 'https://{defaultHost}',
          variables: {
            defaultHost: {
              default: 'www.example.com'
            }
          }
        }
      ]
    }
  }

  # Specify the format of the output Swagger file when running 'rswag:specs:swaggerize'.
  # The swagger_docs configuration option has the filename including format in
  # the key, this may want to be changed to avoid putting yaml in json files.
  # Defaults to json. Accepts ':json' and ':yaml'.
  config.swagger_format = :json
end
