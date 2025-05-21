# -*- encoding: utf-8 -*-
# stub: bx_block_terms_and_conditions 1.1.0 ruby lib

Gem::Specification.new do |s|
  s.name = "bx_block_terms_and_conditions".freeze
  s.version = "1.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.metadata = { "allowed_push_host" => "https://gemfury.com" } if s.respond_to? :metadata=
  s.require_paths = ["lib".freeze]
  s.authors = ["arihant.nahar@protonshub.com".freeze]
  s.date = "2024-05-01"
  s.description = "Description of BxBlockTermsAndConditions.".freeze
  s.email = ["arihant.nahar@protonshub.com".freeze]
  s.homepage = "https://gitlab.builder.ai/builder/builder-bx/bx/blocks/ruby/engines/bx_block_terms_and_conditions".freeze
  s.rubygems_version = "3.3.22".freeze
  s.summary = "Summary of BxBlockTermsAndConditions.".freeze

  s.installed_by_version = "3.3.22" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_runtime_dependency(%q<builder_base>.freeze, [">= 0"])
    s.add_runtime_dependency(%q<builder_json_web_token>.freeze, [">= 0"])
    s.add_runtime_dependency(%q<account_block>.freeze, [">= 0"])
    s.add_runtime_dependency(%q<bx_block_login-3d0582b5>.freeze, [">= 0"])
    s.add_runtime_dependency(%q<bx_block_account_groups>.freeze, [">= 0"])
    s.add_runtime_dependency(%q<bx_block_roles_permissions-c50949d0>.freeze, [">= 0"])
    s.add_development_dependency(%q<rswag>.freeze, [">= 0"])
    s.add_development_dependency(%q<yaml_db>.freeze, [">= 0"])
    s.add_development_dependency(%q<rake_tasks>.freeze, [">= 0"])
    s.add_development_dependency(%q<rspec>.freeze, [">= 0"])
    s.add_development_dependency(%q<rspec-rails>.freeze, [">= 0"])
    s.add_development_dependency(%q<factory_bot>.freeze, [">= 0"])
    s.add_development_dependency(%q<pg>.freeze, [">= 0"])
    s.add_development_dependency(%q<byebug>.freeze, [">= 0"])
    s.add_development_dependency(%q<faker>.freeze, [">= 0"])
    s.add_development_dependency(%q<shoulda-matchers>.freeze, [">= 0"])
    s.add_development_dependency(%q<standard>.freeze, [">= 0"])
    s.add_development_dependency(%q<pry-rails>.freeze, [">= 0"])
    s.add_development_dependency(%q<appraisal>.freeze, [">= 0"])
  else
    s.add_dependency(%q<builder_base>.freeze, [">= 0"])
    s.add_dependency(%q<builder_json_web_token>.freeze, [">= 0"])
    s.add_dependency(%q<account_block>.freeze, [">= 0"])
    s.add_dependency(%q<bx_block_login-3d0582b5>.freeze, [">= 0"])
    s.add_dependency(%q<bx_block_account_groups>.freeze, [">= 0"])
    s.add_dependency(%q<bx_block_roles_permissions-c50949d0>.freeze, [">= 0"])
    s.add_dependency(%q<rswag>.freeze, [">= 0"])
    s.add_dependency(%q<yaml_db>.freeze, [">= 0"])
    s.add_dependency(%q<rake_tasks>.freeze, [">= 0"])
    s.add_dependency(%q<rspec>.freeze, [">= 0"])
    s.add_dependency(%q<rspec-rails>.freeze, [">= 0"])
    s.add_dependency(%q<factory_bot>.freeze, [">= 0"])
    s.add_dependency(%q<pg>.freeze, [">= 0"])
    s.add_dependency(%q<byebug>.freeze, [">= 0"])
    s.add_dependency(%q<faker>.freeze, [">= 0"])
    s.add_dependency(%q<shoulda-matchers>.freeze, [">= 0"])
    s.add_dependency(%q<standard>.freeze, [">= 0"])
    s.add_dependency(%q<pry-rails>.freeze, [">= 0"])
    s.add_dependency(%q<appraisal>.freeze, [">= 0"])
  end
end
