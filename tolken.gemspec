# frozen_string_literal: true

lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "tolken/version"

Gem::Specification.new do |spec|
  spec.name          = "tolken"
  spec.version       = Tolken::VERSION
  spec.authors       = ["Nicklas Ramhöj", "Julia Friberg"]
  spec.email         = ["nicklas.ramhoj@varvet.com", "julia.friberg@varvet.com"]

  spec.summary       = "Straightforward Rails database translations using psql jsonb"
  spec.description   = %q{
    Tolken's API is more verbose than most similar gems. The idea is that you should be aware of when you're dealing with
    translatable fields and what language you're interested in in any given moment. In tolken a translatable field is just a
    Ruby hash which makes it easy to reason about.
  }
  spec.homepage      = "https://github.com/varvet/tolken"
  spec.license       = "MIT"

  spec.files         = %x(git ls-files -z).split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "rails", "~> 5.2"

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "pg"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "rubocop", "= 0.68.0"
  spec.add_development_dependency "rubocop-rspec"
  spec.add_development_dependency "simple_form"
  spec.add_development_dependency "simplecov"
  spec.add_development_dependency "with_model"
end
