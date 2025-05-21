# -*- encoding: utf-8 -*-
# stub: sixarm_ruby_unaccent 1.2.2 ruby lib

Gem::Specification.new do |s|
  s.name = "sixarm_ruby_unaccent".freeze
  s.version = "1.2.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["SixArm".freeze]
  s.cert_chain = ["-----BEGIN CERTIFICATE-----\nMIIEbDCCAtSgAwIBAgIBATANBgkqhkiG9w0BAQsFADA+MQ8wDQYDVQQDDAZzaXhh\ncm0xFjAUBgoJkiaJk/IsZAEZFgZzaXhhcm0xEzARBgoJkiaJk/IsZAEZFgNjb20w\nHhcNMjMwNTIyMTc0NDE3WhcNMjQwNTIxMTc0NDE3WjA+MQ8wDQYDVQQDDAZzaXhh\ncm0xFjAUBgoJkiaJk/IsZAEZFgZzaXhhcm0xEzARBgoJkiaJk/IsZAEZFgNjb20w\nggGiMA0GCSqGSIb3DQEBAQUAA4IBjwAwggGKAoIBgQCq4af9gCpSJem8PTmowTIK\n0GvWPKGTxELRIhXgJB/XAH2s7YBGjsm6H4DOVUXBgksaSQdD1JFAUz8zhr1c3Awq\nml+CzyAkzfvPYoA/a+OEH3LNhE7NNUwgjjp00OqBGjnMlJ5KLA+xHbddQ+5NxlUC\nH9IY4K2A/thw1rabXogx2aE+BxDnOxbrR7UrdtYAYoeUnvDQ8nXJVxyC1fgBxlr7\nUFJlwTD1PJEEQEq0ZjMwUk2yzFsEuGGwNK1JqI3h+B2cyQRPams6lwdx9exrbQTE\nKFiV1YsxuPVKgLytXP5Uh8i9KZ1ewn8AegMD8KEp/34lGXE/TMdVA+y5cHBFB0yk\nIqprvXlYuHA91puxveeLVGI0J525ofwhCIOFwpUhCOAx33R+P99DMvHoH31l2zhf\ntwC2VSKHNLguBWkrgUZAZ4los7PNQKitItQryrmPU4YDmGlr9NiHOkRf5QGLkRpZ\nAa6dmCZJFbTft62oO4pGIjAca9lGqxRQzS3sPbUaMhcCAwEAAaN1MHMwCQYDVR0T\nBAIwADALBgNVHQ8EBAMCBLAwHQYDVR0OBBYEFBo7Nih7O7s2WBXOefJNRvGlWjwH\nMBwGA1UdEQQVMBOBEXNpeGFybUBzaXhhcm0uY29tMBwGA1UdEgQVMBOBEXNpeGFy\nbUBzaXhhcm0uY29tMA0GCSqGSIb3DQEBCwUAA4IBgQBWMdNk1kGW41jOGyCCSkfw\nkaVAURzA481CzdzicToRYkZXiM5p3TqyAFPiPhxpOxeuXfimdt4//uJoITWQD5Fq\nNr6bz2X1JGe23ZUSV/pT9HZzl9pSKrwu1E49s5Fd0Rux8NO8M2w3oeZzqxNIa9vh\nze/vY1tkKH12iHoI8RrtpA41Al79j8mnEj8Jmf8S+xveusaRMnPkWPKl1cIkVS2k\n8oj6PNP/lK+P2TFa0hsMOeQNowTfKRacm0hn/eaYIwLbx3JFJ+lt5w9YAdCta+E5\nfr7EEQwzNmMcy7JldkX/WgmeEQCzqlRy4l+jl2ZHxYJLXAiYkkzsWJQsQ4hqpVnx\n1psx5VLih5iWoiEuthGA7x5i0HEgBWkI1BLyIlC2YsXpJ+YAWDowK+On40R07qOn\nh3dRMKiZUNmDeYWbQZE/IU/yO1utU5j/g73CBa+J51KcypcvK0bdlBb8KQfrYbpt\nWpzwx/JmdyV61orp2CQUQxMmEOIh9d8OMAdjOw6ooaw=\n-----END CERTIFICATE-----\n".freeze]
  s.date = "2023-05-23"
  s.description = "Unaccent replaces a string's accented characters with unaccented characters".freeze
  s.email = "sixarm@sixarm.com".freeze
  s.homepage = "http://sixarm.com/".freeze
  s.licenses = ["Apache-2.0".freeze, "Artistic-2.0".freeze, "BSD-3-Clause".freeze, "CC-BY-NC-SA-4.0".freeze, "AGPL-3.0".freeze, "EPL-1.0".freeze, "GPL-2.0".freeze, "GPL-3.0".freeze, "LGPL-3.0".freeze, "MIT".freeze, "MPL-2.0".freeze, "Ruby".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 2.2".freeze)
  s.rubygems_version = "3.3.22".freeze
  s.summary = "SixArm.com \u2192 Ruby \u2192 Unaccent".freeze

  s.installed_by_version = "3.3.22" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_development_dependency(%q<minitest>.freeze, [">= 5.12", "< 6"])
    s.add_development_dependency(%q<sixarm_ruby_minitest_extensions>.freeze, [">= 1.0.8", "< 2"])
    s.add_development_dependency(%q<rake>.freeze, [">= 12.3.3", "< 13"])
    s.add_development_dependency(%q<simplecov>.freeze, [">= 0.18.0", "< 2"])
  else
    s.add_dependency(%q<minitest>.freeze, [">= 5.12", "< 6"])
    s.add_dependency(%q<sixarm_ruby_minitest_extensions>.freeze, [">= 1.0.8", "< 2"])
    s.add_dependency(%q<rake>.freeze, [">= 12.3.3", "< 13"])
    s.add_dependency(%q<simplecov>.freeze, [">= 0.18.0", "< 2"])
  end
end
