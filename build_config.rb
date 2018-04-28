MRuby::Build.new do |conf|
  toolchain :gcc
  conf.gembox 'default'
end

MRuby::CrossBuild.new('emscripten') do |conf|
  toolchain :clang
  conf.gembox 'default'
  conf.cc.command = 'emcc'
  conf.cc.flags = %W(-Os)
  conf.linker.command = 'emcc'
  conf.archiver.command = 'emar'
end
