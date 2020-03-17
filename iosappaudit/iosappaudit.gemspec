
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "iosappaudit/version"

Gem::Specification.new do |s|
  s.name        = 'iosappaudit'
  s.version     = IOSAppAudit::VERSION
  s.date        = '2019-01-23'
  s.summary     = "Audit"
  s.description = "Audit"
  s.authors     = ["Gaétan Zanella"]
  s.email       = 'gaetan.zanella@gmail.com'
  # use `git ls-files -coz -x *.gem` for development

  s.homepage    = 'http://rubygems.org/gems/hola'
  s.license     = 'MIT'
  s.add_dependency "xcodeproj", "~> 1.4"
  s.add_dependency "r18n-core", "~> 3.2"
  s.add_dependency "colorize", "~> 0.8"
  s.add_development_dependency "byebug", "~> 10.0"

    # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if s.respond_to?(:metadata)
    s.metadata["allowed_push_host"] = "https://rubygems.org"
    s.metadata["homepage_uri"] = s.homepage
    s.metadata["source_code_uri"] = "https://github.com/faberNovel/iosappaudit"
    s.metadata["changelog_uri"] = "https://github.com/faberNovel/iosappaudit/blob/master/CHANGELOG.md"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  s.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  s.bindir        = "exe"
  s.executables = ["iosappaudit"]
  s.require_paths = ["lib"]
end
