
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "tolken/version"

Gem::Specification.new do |spec|
  spec.name          = "tolken"
  spec.version       = Tolken::VERSION
  spec.authors       = ["Nicklas Ramhöj, Julia Fridberg"]
  spec.email         = ["nicklas.ramhoj@varvet.com, julia.fridberg@varvet.com"]

  spec.summary       = "A down-to-earth database translation Gem for Rails using psql jsonb"
  spec.description   = """
    #{spec.summary}. Designed to be less magic than most other translation projects.
    Tolken's API is more verbose than most similar gems. The philosophy is that you should be aware of when you're dealing with translatable fields and what language you're interested in in any given moment. This comes from experience working with gems such as [Globalize](https://github.com/globalize/globalize), while it might fit some projects we've found that the magic that starts out as a convenience quickly becomes a liability.
    In Tolken a translatable field is just a Ruby hash which makes it easy to reason about. See *Usage* for details.
  """
  spec.homepage      = "TODO: Put your gem's website or public repo URL here."
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "rails", "5.2.0.rc2"

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "pg"
  spec.add_development_dependency "with_model"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "simple_form"
end
