# -*- encoding: utf-8 -*-
# stub: bx_block_stripe_order_management 0.3.0 ruby lib

Gem::Specification.new do |s|
  s.name = "bx_block_stripe_order_management".freeze
  s.version = "0.3.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.metadata = { "allowed_push_host" => "https://gemfury.com" } if s.respond_to? :metadata=
  s.require_paths = ["lib".freeze]
  s.authors = ["Alexey Schepin".freeze]
  s.date = "2024-05-14"
  s.description = "Description of BxBlockStripeOrderManagement.".freeze
  s.email = ["alexey.schepin@builder.ai".freeze]
  s.homepage = "https://gitlab.builder.ai/builder/builder-bx/bx/blocks/ruby/engines/bx_block_stripe_order_management".freeze
  s.rubygems_version = "3.3.22".freeze
  s.summary = "Summary of BxBlockStripeOrderManagement.".freeze

  s.installed_by_version = "3.3.22" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_runtime_dependency(%q<builder_base>.freeze, [">= 0"])
    s.add_runtime_dependency(%q<bx_block_order_management-674a3e38>.freeze, [">= 0"])
    s.add_runtime_dependency(%q<bx_block_stripe_integration>.freeze, [">= 0"])
    s.add_runtime_dependency(%q<rswag>.freeze, [">= 0"])
    s.add_development_dependency(%q<cane>.freeze, [">= 0"])
    s.add_development_dependency(%q<debug>.freeze, [">= 0"])
    s.add_development_dependency(%q<factory_bot>.freeze, [">= 0"])
    s.add_development_dependency(%q<faker>.freeze, [">= 0"])
    s.add_development_dependency(%q<rspec-rails>.freeze, [">= 0"])
    s.add_development_dependency(%q<standard>.freeze, [">= 0"])
    s.add_development_dependency(%q<appraisal>.freeze, [">= 0"])
  else
    s.add_dependency(%q<builder_base>.freeze, [">= 0"])
    s.add_dependency(%q<bx_block_order_management-674a3e38>.freeze, [">= 0"])
    s.add_dependency(%q<bx_block_stripe_integration>.freeze, [">= 0"])
    s.add_dependency(%q<rswag>.freeze, [">= 0"])
    s.add_dependency(%q<cane>.freeze, [">= 0"])
    s.add_dependency(%q<debug>.freeze, [">= 0"])
    s.add_dependency(%q<factory_bot>.freeze, [">= 0"])
    s.add_dependency(%q<faker>.freeze, [">= 0"])
    s.add_dependency(%q<rspec-rails>.freeze, [">= 0"])
    s.add_dependency(%q<standard>.freeze, [">= 0"])
    s.add_dependency(%q<appraisal>.freeze, [">= 0"])
  end
end
