Gem::Specification.new do |spec|
  spec.name = "sequel-hash_id"
  spec.version = "0.1.0"
  spec.authors = ["Adam Daniels"]
  spec.email = "adam@mediadrive.ca"

  spec.summary = %q(Easily obscure the primary key of your Sequel models)

  spec.homepage = "https://github.com/adam12/sequel-hash_id"
  spec.license = "MIT"

  spec.files = ["README.md"] + Dir["lib/**/*.rb"]

  spec.add_dependency "sequel", "~> 4.43"
  spec.add_dependency "hashids", "~> 1.0"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_development_dependency "rubygems-tasks", "~> 0.2"
end
