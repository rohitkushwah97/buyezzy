# -*- encoding: utf-8 -*-
# stub: bx_builder_chain 0.1.18 ruby lib

Gem::Specification.new do |s|
  s.name = "bx_builder_chain".freeze
  s.version = "0.1.18"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Paul Ketelle".freeze]
  s.bindir = "exe".freeze
  s.date = "2024-02-19"
  s.description = "LangChain but for the builder tech stack.".freeze
  s.email = ["paul.ketelle@builder.ai".freeze]
  s.licenses = ["MIT".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 2.6.0".freeze)
  s.rubygems_version = "3.1.6".freeze
  s.summary = "LangChain but for the builder tech stack.".freeze

  s.installed_by_version = "3.1.6" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_runtime_dependency(%q<zeitwerk>.freeze, ["= 2.6.11"])
    s.add_runtime_dependency(%q<baran>.freeze, ["= 0.1.7"])
    s.add_runtime_dependency(%q<sequel>.freeze, ["~> 5.71"])
    s.add_runtime_dependency(%q<pg>.freeze, ["~> 1.5.3"])
    s.add_runtime_dependency(%q<dotenv>.freeze, ["~> 2.8"])
    s.add_runtime_dependency(%q<ruby-openai>.freeze, ["~> 5.1.0"])
    s.add_runtime_dependency(%q<pdf-reader>.freeze, ["~> 2.11.0"])
    s.add_runtime_dependency(%q<nokogiri>.freeze, ["~> 1.8"])
    s.add_runtime_dependency(%q<docx>.freeze, ["~> 0.8.0"])
    s.add_runtime_dependency(%q<roo>.freeze, ["~> 2.8.3"])
    s.add_runtime_dependency(%q<async>.freeze, ["~> 1.31.0"])
  else
    s.add_dependency(%q<zeitwerk>.freeze, ["= 2.6.11"])
    s.add_dependency(%q<baran>.freeze, ["= 0.1.7"])
    s.add_dependency(%q<sequel>.freeze, ["~> 5.71"])
    s.add_dependency(%q<pg>.freeze, ["~> 1.5.3"])
    s.add_dependency(%q<dotenv>.freeze, ["~> 2.8"])
    s.add_dependency(%q<ruby-openai>.freeze, ["~> 5.1.0"])
    s.add_dependency(%q<pdf-reader>.freeze, ["~> 2.11.0"])
    s.add_dependency(%q<nokogiri>.freeze, ["~> 1.8"])
    s.add_dependency(%q<docx>.freeze, ["~> 0.8.0"])
    s.add_dependency(%q<roo>.freeze, ["~> 2.8.3"])
    s.add_dependency(%q<async>.freeze, ["~> 1.31.0"])
  end
end
