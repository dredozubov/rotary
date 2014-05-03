$LOAD_PATH << File.expand_path('./lib')
require "ext_pool"
 
task :build do
  system "gem build ext_pool.gemspec"
end
 
task :release => :build do
  system "gem push ext_pool-#{ExtPool::VERSION}"
end

task :console do
  require 'irb'
  require 'irb/completion'
  require 'ext_pool'
  ARGV.clear
  IRB.start
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
