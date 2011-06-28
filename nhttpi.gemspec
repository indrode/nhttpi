lib = File.expand_path("../lib/", __FILE__)
$:.unshift lib unless $:.include?(lib)

require "nhttpi/version"

Gem::Specification.new do |s|
  s.name        = "nhttpi"
  s.version     = NHTTPI::VERSION
  s.authors     = ["Indro De"]
  s.email       = ["indro.de@gmail.com"]
  s.homepage    = ""
  s.summary     = "Interface for Ruby HTTP libraries"
  s.description = "NHTTPI provides a common interface for Ruby HTTP libraries."

  s.rubyforge_project = s.name

  s.add_dependency "rack"
  s.add_dependency "pyu-ntlm-http",           ">= 0.1.3.1"

  s.add_development_dependency "rspec",       "~> 2.2"
  s.add_development_dependency "autotest"
  s.add_development_dependency "mocha",       "~> 0.9.9"
  s.add_development_dependency "webmock",     "~> 1.4.0"

  s.files = `git ls-files`.split("\n")
  s.require_path = "lib"
end
