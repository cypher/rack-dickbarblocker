# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{rack-dickbarblocker}
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Markus Prinz"]
  s.date = %q{2009-04-11}
  s.email = %q{markus.prinz@nuclearsquid.com}
  s.extra_rdoc_files = [
    "README.rdoc"
  ]
  s.files = [
    "README.rdoc",
    "Rakefile",
    "VERSION.yml",
    "lib/rack/contrib/dick_bar_blocker.rb",
    "test/spec_rack_dick_bar_blocker.rb"
  ]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/cypher/rack-dickbarblocker}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{Shows a special page to anyone using the DiggBar}
  s.test_files = [
    "test/spec_rack_dick_bar_blocker.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
