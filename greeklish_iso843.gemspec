require File.expand_path('lib/greeklish_iso843/version', __dir__)

Gem::Specification.new do |gem|
  gem.name          = 'greeklish_iso843'
  gem.version       = GreeklishIso843::VERSION
  gem.author        = 'Angelos Orfanakos'
  gem.email         = 'rubygems@angelos.dev'
  gem.homepage      = 'https://github.com/agorf/greeklish_iso843'
  gem.summary       = 'Convert Greek text to Greeklish conforming to ISO 843 (ELOT 743)'
  gem.license       = 'MIT'

  gem.files         = Dir['lib/**/*.rb', 'bin/*', '*.md', 'LICENSE.txt']
  gem.executables   = Dir['bin/*'].map { |f| File.basename(f) }
  gem.require_paths = ['lib']

  gem.required_ruby_version = '>= 2.5.1'
end
