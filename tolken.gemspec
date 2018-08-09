
# frozen_string_literal: true

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
    #{spec.summary}.
    Designed to be less magic than most other translation projects. You should be aware of when you're dealing with
    translatable fields and what language you're interested in at any given moment. This comes from experience working with
    gems such as Globalize, while it might fit some projects we've found that the magic that starts out as a convenience
    quickly becomes a liability. In Tolken a translatable field is just a Ruby hash which makes it easy to reason about.
  """
  spec.homepage      = "https://github.com/varvet/tolken"
  spec.license       = "MIT"

  spec.files         = %x(git ls-files -z).split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "rails", "5.2.0.rc2"

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "pg", "~> 1.0"
  spec.add_development_dependency "pry", "~>0.11"
  spec.add_development_dependency "rake", "~> 12.3"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "rubocop", "0.52.1"
  spec.add_development_dependency "rubocop-rspec", "~> 1.23"
  spec.add_development_dependency "simple_form", "~> 4.0"
  spec.add_development_dependency "simplecov", "~> 0.16"
  spec.add_development_dependency "with_model", "~> 2.0"
end
