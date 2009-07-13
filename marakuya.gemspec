# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{marakuya}
  s.version = "0.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Macario Ortega"]
  s.cert_chain = ["/Users/sistemasinteractivos/.gem/gem-public_cert.pem"]
  s.date = %q{2009-07-13}
  s.description = %q{}
  s.email = ["macarui@gmail.com"]
  s.extra_rdoc_files = ["History.txt", "Manifest.txt", "PostInstall.txt", "README.rdoc"]
  s.files = ["History.txt", "Manifest.txt", "PostInstall.txt", "README.rdoc", "Rakefile", "lib/marakuya.rb", "script/console", "script/destroy", "script/generate", "test/test_helper.rb", "test/test_marakuya.rb"]
  s.has_rdoc = true
  s.homepage = %q{Tropicallized markdown.}
  s.rdoc_options = ["--main", "README.rdoc"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{marakuya}
  s.rubygems_version = %q{1.3.1}
  s.signing_key = %q{/Users/sistemasinteractivos/.gem/gem-private_key.pem}
  s.summary = %q{}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rdiscount>, [">= 1.3.4"])
      s.add_development_dependency(%q<newgem>, [">= 1.4.1"])
      s.add_development_dependency(%q<hoe>, [">= 1.8.0"])
    else
      s.add_dependency(%q<rdiscount>, [">= 1.3.4"])
      s.add_dependency(%q<newgem>, [">= 1.4.1"])
      s.add_dependency(%q<hoe>, [">= 1.8.0"])
    end
  else
    s.add_dependency(%q<rdiscount>, [">= 1.3.4"])
    s.add_dependency(%q<newgem>, [">= 1.4.1"])
    s.add_dependency(%q<hoe>, [">= 1.8.0"])
  end
end