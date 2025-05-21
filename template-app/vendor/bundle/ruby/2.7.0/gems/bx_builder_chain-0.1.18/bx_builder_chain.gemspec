# frozen_string_literal: true

require_relative "lib/bx_builder_chain/version"

Gem::Specification.new do |spec|
  spec.name = "bx_builder_chain"
  spec.version = BxBuilderChain::VERSION
  spec.authors = ["Paul Ketelle"]
  spec.email = ["paul.ketelle@builder.ai"]

  spec.summary = "LangChain but for the builder tech stack."
  spec.description = "LangChain but for the builder tech stack."
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|circleci)|appveyor)})
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "zeitwerk", "2.6.11"
  spec.add_dependency "baran", "0.1.7"
  spec.add_dependency "sequel", "~> 5.71"
  spec.add_dependency "pg", "~> 1.5.3"
  spec.add_dependency 'dotenv', "~> 2.8"
  spec.add_dependency "ruby-openai", "~> 5.1.0"
  spec.add_dependency "pdf-reader", "~> 2.11.0"
  spec.add_dependency "nokogiri", "~> 1.8" 
  spec.add_dependency "docx", "~> 0.8.0"
  spec.add_dependency "roo", "~> 2.8.3"
  spec.add_dependency "async", "~> 1.31.0"
end
