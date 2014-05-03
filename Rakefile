$LOAD_PATH << File.expand_path('./lib')
require "ext_pool"
 
task :build do
  system "gem build ext_pool.gemspec"
end
 
task :release => :build do
  system "gem push ext_pool-#{ExtPool::VERSION}"
end
