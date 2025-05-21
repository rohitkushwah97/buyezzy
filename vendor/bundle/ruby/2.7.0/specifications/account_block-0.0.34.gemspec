# -*- encoding: utf-8 -*-
# stub: account_block 0.0.34 ruby lib

Gem::Specification.new do |s|
  s.name = "account_block".freeze
  s.version = "0.0.34"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.metadata = { "allowed_push_host" => "https://gemfury.com" } if s.respond_to? :metadata=
  s.require_paths = ["lib".freeze]
  s.authors = ["Travis Herrick".freeze, "Vadym Yershov".freeze, "Silvio Vaz".freeze]
  s.date = "2022-11-15"
  s.email = ["travis.herrick@builder.ai".freeze, "vyershov@archer-soft.com".freeze, "silvio.vaz@builder.ai".freeze]
  s.homepage = "https://gitlab.builder.ai/builder/builder-bx/bx/blocks/ruby/engines/account_block".freeze
  s.rubygems_version = "3.1.6".freeze
  s.summary = "AccountBlock".freeze

  s.installed_by_version = "3.1.6" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_runtime_dependency(%q<builder_base>.freeze, [">= 0"])
    s.add_runtime_dependency(%q<builder_json_web_token>.freeze, ["= 0.0.7"])
    s.add_runtime_dependency(%q<bx_block_sms>.freeze, [">= 0"])
    s.add_runtime_dependency(%q<wisper>.freeze, ["= 2.0.1"])
    s.add_runtime_dependency(%q<bcrypt>.freeze, ["= 3.1.16"])
    s.add_runtime_dependency(%q<phonelib>.freeze, ["= 0.6.47"])
    s.add_runtime_dependency(%q<countries>.freeze, ["= 3.0.1"])
    s.add_development_dependency(%q<pg>.freeze, ["= 1.2.3"])
    s.add_development_dependency(%q<rake_tasks>.freeze, ["= 5.1.1"])
    s.add_development_dependency(%q<rspec>.freeze, ["= 3.10.0"])
    s.add_development_dependency(%q<rspec-rails>.freeze, ["= 4.0.2"])
    s.add_development_dependency(%q<factory_bot>.freeze, ["= 6.1.0"])
    s.add_development_dependency(%q<rswag>.freeze, [">= 0"])
    s.add_development_dependency(%q<standard>.freeze, [">= 0"])
  else
    s.add_dependency(%q<builder_base>.freeze, [">= 0"])
    s.add_dependency(%q<builder_json_web_token>.freeze, ["= 0.0.7"])
    s.add_dependency(%q<bx_block_sms>.freeze, [">= 0"])
    s.add_dependency(%q<wisper>.freeze, ["= 2.0.1"])
    s.add_dependency(%q<bcrypt>.freeze, ["= 3.1.16"])
    s.add_dependency(%q<phonelib>.freeze, ["= 0.6.47"])
    s.add_dependency(%q<countries>.freeze, ["= 3.0.1"])
    s.add_dependency(%q<pg>.freeze, ["= 1.2.3"])
    s.add_dependency(%q<rake_tasks>.freeze, ["= 5.1.1"])
    s.add_dependency(%q<rspec>.freeze, ["= 3.10.0"])
    s.add_dependency(%q<rspec-rails>.freeze, ["= 4.0.2"])
    s.add_dependency(%q<factory_bot>.freeze, ["= 6.1.0"])
    s.add_dependency(%q<rswag>.freeze, [">= 0"])
    s.add_dependency(%q<standard>.freeze, [">= 0"])
  end
end
