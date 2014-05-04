$LOAD_PATH << File.expand_path('./lib')
require "rotary"
 
task :build do
  system "gem build rotary.gemspec"
end
 
task :release => :build do
  system "gem push rotary-#{Rotary::VERSION}"
end

task :console do
  require 'pry'
  require 'rotary'
  ARGV.clear
  Pry.start
end
task :c => :console

require 'rake/testtask'

Rake::TestTask.new do |t|
  t.libs << "lib"
  t.libs << "spec"
  t.test_files = FileList['spec/**/*_spec.rb']
  t.verbose = true
end
task :spec => :test
task :default => :test
