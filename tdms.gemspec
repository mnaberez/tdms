Gem::Specification.new do |gem|
  gem.name          = "tdms"
  gem.version       = "0.1.0"
  gem.summary       = "Ruby library to read files in NI TDMS format"
  gem.description   = gem.summary

  gem.required_ruby_version = '>= 1.9.3'
  gem.license       = "BSD"

  gem.authors       = ["Mike Naberezny"]
  gem.email         = ["mike@naberezny.com"]
  gem.homepage      = "https://github.com/mnaberez/tdms"

  gem.files         = `git ls-files`.split($/)
  gem.test_files    = gem.files.grep(%r{^test/})
  gem.require_paths = ["lib"]

  gem.add_development_dependency("rake")
end
