mruby_version = '1.4.1'
require_relative 'lib/wasm/version'

class String
  def colorize(c); "\e[#{c}m#{self}\e[0m" end
  def bold; colorize('1')    end
  def blue; colorize('1;34') end
end

def print_task(task)
  print "\n", "==> ".blue, task.bold, "\n\n"
end

task default: 'install_gem'

desc 'Uninstall the gem'
task :uninstall_gem do
  print_task 'Uninstalling gem'
  system 'gem uninstall wasm --executables'
end

desc 'Build the gem'
task :build_gem => :uninstall_gem do
  print_task 'Building gem'
  system 'gem build wasm.gemspec --verbose'
end

desc 'Install the gem'
task :install_gem => :build_gem do
  print_task 'Installing gem'
  system "gem install wasm-#{WASM::VERSION}.gem --local --verbose"
end

desc 'Clean the project build files'
task :clean do
  print_task 'Cleaning build files'
  FileUtils.remove_dir 'mruby/build', true
  FileUtils.remove_dir 'assets/mruby', true
end

desc 'Build MRuby static library for WebAssembly'
task :build_mruby => :clean do
  print_task 'Building MRuby static library for WebAssembly'
  Dir.chdir('mruby') do
    ENV['MRUBY_CONFIG'] = '../build_config.rb'
    system 'rake'
  end

  FileUtils.mkdir_p 'assets/mruby'
  FileUtils.cp_r 'mruby/include', 'assets/mruby'
  FileUtils.cp 'mruby/build/emscripten/lib/libmruby.a', 'assets/mruby'
end

desc 'Set MRuby submodule to latest release'
task :mruby_latest do
  print_task "Setting MRuby submodule to version #{mruby_version}"
  system 'git submodule update --remote && '\
         'cd mruby && '\
         "git checkout tags/#{mruby_version}"
end

desc 'Set MRuby submodule to master branch'
task :mruby_master do
  print_task 'Setting MRuby submodule to master branch'
  system 'git submodule update --remote && '\
         'cd mruby && '\
         'git checkout master && '\
         'git pull --rebase'
end
