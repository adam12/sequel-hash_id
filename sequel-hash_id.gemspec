Gem::Specification.new do |spec|
  spec.name           = "sequel-hash_id"
  spec.version        = "0.1.2"
  spec.authors        = ["Adam Daniels"]
  spec.email          = "adam@mediadrive.ca"

  spec.summary        = %q(Easily obscure the primary key of your Sequel models)

  spec.homepage       = "https://github.com/adam12/sequel-hash_id"
  spec.license        = "MIT"

  spec.files          = ["README.md"] + Dir["lib/**/*.rb"]
  spec.require_paths  = ["lib"]

  spec.add_dependency "sequel", "~> 5"
  spec.add_dependency "hashids", "~> 1.0"
end
