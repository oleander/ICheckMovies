# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)

Gem::Specification.new do |s|
  s.name        = "icheckmovies"
  s.version     = "0.5.0"
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Linus Oleander"]
  s.email       = ["linus@oleander.nu"]
  s.homepage    = "https://github.com/oleander/icheckmovies"
  s.summary     = %q{Unofficial API for iCheckMovies}
  s.description = %q{Unofficial API for iCheckMovies.com}

  s.rubyforge_project = "icheckmovies"
  
  s.add_dependency("rest-client")
  s.add_dependency("nokogiri")
  
  s.add_development_dependency("vcr")
  s.add_development_dependency("rspec")  
  s.add_development_dependency("webmock")
  
  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
