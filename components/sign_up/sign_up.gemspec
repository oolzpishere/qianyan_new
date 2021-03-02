require_relative "lib/sign_up/version"

Gem::Specification.new do |spec|
  spec.name        = "sign_up"
  spec.version     = SignUp::VERSION
  spec.authors     = [""]
  spec.email       = ["oolzpishere@126.com"]
  spec.homepage    = "https://github.com/oolzpishere"
  spec.summary     = ": Summary of SignUp."
  spec.description = ": Description of SignUp."
  spec.license     = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  spec.metadata["allowed_push_host"] = ": Set to 'http://mygemserver.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/oolzpishere"
  spec.metadata["changelog_uri"] = "https://github.com/oolzpishere"

  spec.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  spec.add_dependency "rails", "~> 6.1.3"
end
