# -*- encoding: utf-8 -*-
# stub: bx_block_contentflag 0.1.2 ruby lib

Gem::Specification.new do |s|
  s.name = "bx_block_contentflag".freeze
  s.version = "0.1.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.metadata = { "allowed_push_host" => "https://gemfury.com", "infra_dependencies" => "" } if s.respond_to? :metadata=
  s.require_paths = ["lib".freeze]
  s.authors = ["Vadym Yershov".freeze]
  s.date = "2024-05-01"
  s.email = ["vyershov@archer-soft.com".freeze]
  s.homepage = "https://gitlab.builder.ai/builder/builder-bx/bx/blocks/ruby/engines/lite-certified/bx_block_contentflag".freeze
  s.rubygems_version = "3.3.22".freeze
  s.summary = "BxBlockContentflag".freeze

  s.installed_by_version = "3.3.22" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_runtime_dependency(%q<builder_base>.freeze, [">= 0"])
    s.add_runtime_dependency(%q<builder_json_web_token>.freeze, [">= 0"])
    s.add_runtime_dependency(%q<account_block>.freeze, [">= 0"])
    s.add_runtime_dependency(%q<bx_block_comments-568532a5>.freeze, [">= 0"])
    s.add_runtime_dependency(%q<bx_block_posts-3dc5b993>.freeze, [">= 0"])
    s.add_runtime_dependency(%q<bx_block_categories-acd0763f>.freeze, [">= 0"])
    s.add_runtime_dependency(%q<rswag>.freeze, [">= 0"])
    s.add_development_dependency(%q<pg>.freeze, [">= 0"])
    s.add_development_dependency(%q<rake_tasks>.freeze, [">= 0"])
    s.add_development_dependency(%q<cane>.freeze, [">= 0"])
    s.add_development_dependency(%q<rspec>.freeze, [">= 0"])
    s.add_development_dependency(%q<rspec-rails>.freeze, [">= 0"])
    s.add_development_dependency(%q<factory_bot>.freeze, [">= 0"])
    s.add_development_dependency(%q<standard>.freeze, [">= 0"])
    s.add_development_dependency(%q<shoulda-matchers>.freeze, [">= 0"])
    s.add_development_dependency(%q<pry>.freeze, [">= 0"])
    s.add_development_dependency(%q<faker>.freeze, [">= 0"])
    s.add_development_dependency(%q<simplecov>.freeze, [">= 0"])
    s.add_development_dependency(%q<rswag-specs>.freeze, [">= 0"])
  else
    s.add_dependency(%q<builder_base>.freeze, [">= 0"])
    s.add_dependency(%q<builder_json_web_token>.freeze, [">= 0"])
    s.add_dependency(%q<account_block>.freeze, [">= 0"])
    s.add_dependency(%q<bx_block_comments-568532a5>.freeze, [">= 0"])
    s.add_dependency(%q<bx_block_posts-3dc5b993>.freeze, [">= 0"])
    s.add_dependency(%q<bx_block_categories-acd0763f>.freeze, [">= 0"])
    s.add_dependency(%q<rswag>.freeze, [">= 0"])
    s.add_dependency(%q<pg>.freeze, [">= 0"])
    s.add_dependency(%q<rake_tasks>.freeze, [">= 0"])
    s.add_dependency(%q<cane>.freeze, [">= 0"])
    s.add_dependency(%q<rspec>.freeze, [">= 0"])
    s.add_dependency(%q<rspec-rails>.freeze, [">= 0"])
    s.add_dependency(%q<factory_bot>.freeze, [">= 0"])
    s.add_dependency(%q<standard>.freeze, [">= 0"])
    s.add_dependency(%q<shoulda-matchers>.freeze, [">= 0"])
    s.add_dependency(%q<pry>.freeze, [">= 0"])
    s.add_dependency(%q<faker>.freeze, [">= 0"])
    s.add_dependency(%q<simplecov>.freeze, [">= 0"])
    s.add_dependency(%q<rswag-specs>.freeze, [">= 0"])
  end
end
