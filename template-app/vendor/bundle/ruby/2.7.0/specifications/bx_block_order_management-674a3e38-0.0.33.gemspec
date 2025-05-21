# -*- encoding: utf-8 -*-
# stub: bx_block_order_management-674a3e38 0.0.33 ruby lib

Gem::Specification.new do |s|
  s.name = "bx_block_order_management-674a3e38".freeze
  s.version = "0.0.33"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.metadata = { "allowed_push_host" => "https://gemfury.com", "infra_dependencies" => "postgresql" } if s.respond_to? :metadata=
  s.require_paths = ["lib".freeze]
  s.authors = ["Vadym Yershov".freeze]
  s.date = "2023-05-10"
  s.email = ["vyershov@archer-soft.com".freeze]
  s.homepage = "https://gitlab.builder.ai/builder/builder-bx/bx/blocks/ruby/engines/bx_block_order_management".freeze
  s.rubygems_version = "3.3.22".freeze
  s.summary = "BxBlockOrderManagement".freeze

  s.installed_by_version = "3.3.22" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_runtime_dependency(%q<aasm>.freeze, ["~> 5.1", ">= 5.1.1"])
    s.add_runtime_dependency(%q<account_block>.freeze, [">= 0"])
    s.add_runtime_dependency(%q<builder_base>.freeze, [">= 0"])
    s.add_runtime_dependency(%q<builder_json_web_token>.freeze, [">= 0"])
    s.add_runtime_dependency(%q<bx_block_catalogue-0e5da613>.freeze, [">= 0"])
    s.add_runtime_dependency(%q<bx_block_coupon_cg-1da92412>.freeze, [">= 0"])
    s.add_runtime_dependency(%q<bx_block_fedex_integration-c7604a00>.freeze, [">= 0"])
    s.add_runtime_dependency(%q<bx_block_login-3d0582b5>.freeze, [">= 0"])
    s.add_runtime_dependency(%q<public_activity>.freeze, [">= 0"])
    s.add_development_dependency(%q<factory_bot>.freeze, [">= 0"])
    s.add_development_dependency(%q<faker>.freeze, [">= 0"])
    s.add_development_dependency(%q<pg>.freeze, [">= 0"])
    s.add_development_dependency(%q<rake_tasks>.freeze, [">= 0"])
    s.add_development_dependency(%q<rspec>.freeze, [">= 0"])
    s.add_development_dependency(%q<rspec-rails>.freeze, [">= 0"])
    s.add_development_dependency(%q<rswag>.freeze, [">= 0"])
    s.add_development_dependency(%q<standard>.freeze, [">= 0"])
    s.add_development_dependency(%q<vcr>.freeze, [">= 0"])
    s.add_development_dependency(%q<yaml_db>.freeze, [">= 0"])
    s.add_development_dependency(%q<shoulda-matchers>.freeze, [">= 0"])
    s.add_development_dependency(%q<simplecov>.freeze, [">= 0"])
  else
    s.add_dependency(%q<aasm>.freeze, ["~> 5.1", ">= 5.1.1"])
    s.add_dependency(%q<account_block>.freeze, [">= 0"])
    s.add_dependency(%q<builder_base>.freeze, [">= 0"])
    s.add_dependency(%q<builder_json_web_token>.freeze, [">= 0"])
    s.add_dependency(%q<bx_block_catalogue-0e5da613>.freeze, [">= 0"])
    s.add_dependency(%q<bx_block_coupon_cg-1da92412>.freeze, [">= 0"])
    s.add_dependency(%q<bx_block_fedex_integration-c7604a00>.freeze, [">= 0"])
    s.add_dependency(%q<bx_block_login-3d0582b5>.freeze, [">= 0"])
    s.add_dependency(%q<public_activity>.freeze, [">= 0"])
    s.add_dependency(%q<factory_bot>.freeze, [">= 0"])
    s.add_dependency(%q<faker>.freeze, [">= 0"])
    s.add_dependency(%q<pg>.freeze, [">= 0"])
    s.add_dependency(%q<rake_tasks>.freeze, [">= 0"])
    s.add_dependency(%q<rspec>.freeze, [">= 0"])
    s.add_dependency(%q<rspec-rails>.freeze, [">= 0"])
    s.add_dependency(%q<rswag>.freeze, [">= 0"])
    s.add_dependency(%q<standard>.freeze, [">= 0"])
    s.add_dependency(%q<vcr>.freeze, [">= 0"])
    s.add_dependency(%q<yaml_db>.freeze, [">= 0"])
    s.add_dependency(%q<shoulda-matchers>.freeze, [">= 0"])
    s.add_dependency(%q<simplecov>.freeze, [">= 0"])
  end
end
