require File.expand_path('lib/greeklish_iso843/version', __dir__)

Gem::Specification.new do |spec|
  spec.name          = 'greeklish_iso843'
  spec.version       = GreeklishIso843::VERSION
  spec.author        = 'Angelos Orfanakos'
  spec.email         = 'rubygems@angelos.dev'
  spec.homepage      = 'https://github.com/agorf/greeklish_iso843'
  spec.summary       = 'Convert Greek text to Greeklish conforming to ISO 843 (ELOT 743)'
  spec.license       = 'MIT'

  spec.files         = Dir['lib/**/*.rb', 'bin/*', '*.md', 'LICENSE.txt']
  spec.executables   = Dir['bin/*'].map { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.required_ruby_version = '>= 2.5.1'
end
