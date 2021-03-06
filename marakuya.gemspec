# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{marakuya}
  s.version = "0.5"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Macario Ortega"]
  s.date = %q{2009-07-17}
  s.description = %q{}
  s.email = ["macarui@gmail.com"]
  s.extra_rdoc_files = ["History.txt", "Manifest.txt", "README.rdoc"]
  s.files = ["History.txt", "Manifest.txt", "README.rdoc", "Rakefile", "init.rb", "lib/marakuya.rb", "marakuya.gemspec", "script/console", "script/destroy", "script/generate", "spec/marakuya_spec.rb"]
  s.has_rdoc = true
  s.homepage = %q{Tropicalized markdown.}
  s.rdoc_options = ["--main", "README.rdoc"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{marakuya}
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rdiscount>, [">= 1.3.4"])
      s.add_runtime_dependency(%q<maca-evil_spambots>, [">= 0.4.2"])
      s.add_development_dependency(%q<newgem>, [">= 1.4.1"])
      s.add_development_dependency(%q<hoe>, [">= 1.8.0"])
    else
      s.add_dependency(%q<rdiscount>, [">= 1.3.4"])
      s.add_dependency(%q<maca-evil_spambots>, [">= 0.4.2"])
      s.add_dependency(%q<newgem>, [">= 1.4.1"])
      s.add_dependency(%q<hoe>, [">= 1.8.0"])
    end
  else
    s.add_dependency(%q<rdiscount>, [">= 1.3.4"])
    s.add_dependency(%q<maca-evil_spambots>, [">= 0.4.2"])
    s.add_dependency(%q<newgem>, [">= 1.4.1"])
    s.add_dependency(%q<hoe>, [">= 1.8.0"])
  end
end
