require_relative 'lib/wasm/version'

Gem::Specification.new do |s|
  s.name        = 'wasm'
  s.version     = WASM::VERSION
  s.summary     = 'Ruby on WebAssembly'
  s.description = 'Helping you get started with Ruby and WebAssembly'
  s.homepage    = 'https://github.com/blacktm/ruby-wasm'
  s.license     = 'MIT'
  s.author      = 'Tom Black'
  s.email       = 'tom@blacktm.com'

  s.files = Dir.glob('lib/**/*') +
            Dir.glob('assets/**/*') +
            ['build_config.rb']
  s.executables << 'ruby-wasm'
end
