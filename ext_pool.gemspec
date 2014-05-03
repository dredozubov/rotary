$LOAD_PATH.unshift File.join(File.dirname(__FILE__), 'lib')
require "ext_pool/version"
 
Gem::Specification.new do |s|
  s.name              = "ext_pool"
  s.version           = ExtPool::VERSION
  s.date              = Time.now.strftime('%Y-%m-%d')
  s.summary           = "Generic pool with pluggable backends."
  s.homepage          = "http://github.com/dredozubov/ext_pool"
  s.email             = "denis.redozubov@gmail.com"
  s.authors           = [ "Denis Redozubov" ]
  s.has_rdoc          = false

  s.files             = %w( README.md Rakefile LICENSE )
  s.files            += Dir.glob("lib/**/*")
  s.files            += Dir.glob("bin/**/*")
  s.files            += Dir.glob("test/**/*")

  s.add_runtime_dependency 'rake', '~> 10.2.0'
  s.add_development_dependency 'redis', '~> 3.0.7'

  s.description       = <<desc
  Generic pool with pluggable backends for external storage. This way pool can be used by multiple application servers. It can be used to store sessions for external services..
desc

end
