Gem::Specification.new do |spec|
  s.name        = 'iosappaudit'
  s.version     = '1.0.0'
  s.executables << 'ccios'
  s.date        = '2019-01-23'
  s.summary     = "Audit"
  s.description = "Audit"
  s.authors     = ["Gaétan Zanella"]
  s.email       = 'gaetan.zanella@gmail.com'
  # use `git ls-files -coz -x *.gem` for development
  s.files       = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  s.homepage    = 'http://rubygems.org/gems/hola'
  s.license     = 'MIT'
end
