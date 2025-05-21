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

# 3rd party gems
require 'fast_jsonapi' # support for BuilderBase::BaseSerializer without Rails

# custom gems
require 'builder_base/../../app/serializers/builder_base/base_serializer'

# unit-testable classes/modules
[
  './app/serializers/**/*.rb',
  './app/services/**/*.rb',
].each do |glob|
  Dir[glob].each do |path|
    require path
  end
end

# spec support files
Dir['./spec/support/unit/**/*.rb'].each do |path|
  require path
end

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups

  config.disable_monkey_patching!

  config.backtrace_exclusion_patterns = [
    /\/gems\//,
  ]

  config.order = :random

  Kernel.srand config.seed
end
