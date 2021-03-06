$:.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "aristo_lms/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |spec|
  spec.name        = "aristo_lms"
  spec.version     = AristoLms::VERSION
  spec.authors     = ["Minat Silvester"]
  spec.email       = ["minatsilvester@gmail.com"]
  spec.homepage    = ""
  spec.summary     = "Summary of AristoLms."
  spec.description = "Description of AristoLms."
  spec.license     = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  spec.add_dependency "rails", "~> 6.0.3", ">= 6.0.3.2"

  spec.add_dependency 'turbolinks', '~> 5'

  spec.add_dependency 'slim-rails'

  spec.add_dependency 'bootstrap-sass'

  spec.add_dependency 'closure_tree'

  spec.add_dependency "jquery-rails"

  spec.add_dependency "acts_as_list"

  spec.add_dependency "jquery-ui-rails"

  spec.add_development_dependency "pg"
end
