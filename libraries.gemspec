# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "libraries/version"

Gem::Specification.new do |s|
  s.name        = "libraries"
  s.version     = Libraries::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["On-Site.com"]
  s.email       = ["opensource@on-site.com"]
  s.homepage    = "http://rubygems.org/gems/libraries"
  s.summary     = %q{Common Libraries and Ruby/Rails extensions}
  s.description = %q{Common Libraries and Ruby/Rails extensions}

  s.rubyforge_project = "libraries"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
