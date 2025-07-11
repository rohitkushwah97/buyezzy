# -*- encoding: utf-8 -*-
# stub: diff-lcs 1.6.0 ruby lib

Gem::Specification.new do |s|
  s.name = "diff-lcs".freeze
  s.version = "1.6.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.metadata = { "changelog_uri" => "https://github.com/halostatue/diff-lcs/blob/main/CHANGELOG.md", "rubygems_mfa_required" => "true" } if s.respond_to? :metadata=
  s.require_paths = ["lib".freeze]
  s.authors = ["Austin Ziegler".freeze]
  s.date = "2025-02-13"
  s.description = "Diff::LCS computes the difference between two Enumerable sequences using the\nMcIlroy-Hunt longest common subsequence (LCS) algorithm. It includes utilities\nto create a simple HTML diff output format and a standard diff-like tool.\n\nThis is release 1.4.3, providing a simple extension that allows for\nDiff::LCS::Change objects to be treated implicitly as arrays and fixes a number\nof formatting issues.\n\nRuby versions below 2.5 are soft-deprecated, which means that older versions are\nno longer part of the CI test suite. If any changes have been introduced that\nbreak those versions, bug reports and patches will be accepted, but it will be\nup to the reporter to verify any fixes prior to release. The next major release\nwill completely break compatibility.".freeze
  s.email = ["halostatue@gmail.com".freeze]
  s.executables = ["htmldiff".freeze, "ldiff".freeze]
  s.extra_rdoc_files = ["CHANGELOG.md".freeze, "CODE_OF_CONDUCT.md".freeze, "CONTRIBUTING.md".freeze, "CONTRIBUTORS.md".freeze, "Contributing.md".freeze, "LICENCE.md".freeze, "Manifest.txt".freeze, "README.md".freeze, "SECURITY.md".freeze, "docs/COPYING.txt".freeze, "docs/artistic.txt".freeze]
  s.files = ["CHANGELOG.md".freeze, "CODE_OF_CONDUCT.md".freeze, "CONTRIBUTING.md".freeze, "CONTRIBUTORS.md".freeze, "Contributing.md".freeze, "LICENCE.md".freeze, "Manifest.txt".freeze, "README.md".freeze, "SECURITY.md".freeze, "bin/htmldiff".freeze, "bin/ldiff".freeze, "docs/COPYING.txt".freeze, "docs/artistic.txt".freeze]
  s.homepage = "https://github.com/halostatue/diff-lcs".freeze
  s.licenses = ["MIT".freeze, "Artistic-1.0-Perl".freeze, "GPL-2.0-or-later".freeze]
  s.rdoc_options = ["--main".freeze, "README.md".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 1.8".freeze)
  s.rubygems_version = "3.1.6".freeze
  s.summary = "Diff::LCS computes the difference between two Enumerable sequences using the McIlroy-Hunt longest common subsequence (LCS) algorithm".freeze

  s.installed_by_version = "3.1.6" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_development_dependency(%q<hoe>.freeze, [">= 3.0", "< 5"])
    s.add_development_dependency(%q<hoe-doofus>.freeze, ["~> 1.0"])
    s.add_development_dependency(%q<hoe-gemspec2>.freeze, ["~> 1.1"])
    s.add_development_dependency(%q<hoe-git2>.freeze, ["~> 1.7"])
    s.add_development_dependency(%q<hoe-rubygems>.freeze, ["~> 1.0"])
    s.add_development_dependency(%q<rspec>.freeze, [">= 2.0", "< 4"])
    s.add_development_dependency(%q<rake>.freeze, [">= 10.0", "< 14"])
    s.add_development_dependency(%q<rdoc>.freeze, [">= 6.3.1", "< 7"])
    s.add_development_dependency(%q<simplecov>.freeze, ["~> 0.21"])
  else
    s.add_dependency(%q<hoe>.freeze, [">= 3.0", "< 5"])
    s.add_dependency(%q<hoe-doofus>.freeze, ["~> 1.0"])
    s.add_dependency(%q<hoe-gemspec2>.freeze, ["~> 1.1"])
    s.add_dependency(%q<hoe-git2>.freeze, ["~> 1.7"])
    s.add_dependency(%q<hoe-rubygems>.freeze, ["~> 1.0"])
    s.add_dependency(%q<rspec>.freeze, [">= 2.0", "< 4"])
    s.add_dependency(%q<rake>.freeze, [">= 10.0", "< 14"])
    s.add_dependency(%q<rdoc>.freeze, [">= 6.3.1", "< 7"])
    s.add_dependency(%q<simplecov>.freeze, ["~> 0.21"])
  end
end
