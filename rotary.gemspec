$LOAD_PATH.unshift File.join(File.dirname(__FILE__), 'lib')
require "rotary/version"
 
Gem::Specification.new do |s|
  s.name              = "rotary"
  s.licenses          = ['MIT']
  s.version           = Rotary::VERSION
  s.date              = Time.now.strftime('%Y-%m-%d')
  s.summary           = "Generic pool with pluggable backends."
  s.homepage          = "http://github.com/dredozubov/rotary"
  s.email             = "denis.redozubov@gmail.com"
  s.authors           = [ "Denis Redozubov" ]
  s.has_rdoc          = false

  s.files             = %w( README.md Rakefile LICENSE )
  s.files            += Dir.glob("lib/**/*")
  s.files            += Dir.glob("bin/**/*")
  s.files            += Dir.glob("test/**/*")

  s.required_ruby_version = '~> 2.0'
  s.add_runtime_dependency 'rake', '~> 10.2', '>= 10.2.0'
  s.add_runtime_dependency 'redis', '~> 3.0', '~> 3.0.7'
  s.add_development_dependency 'pry', '~> 0.9', '~> 0.9.12.6'
  s.add_development_dependency 'turn', '~> 0.9', '~> 0.9.7'

  s.description       = <<desc
  Generic pool with pluggable backends for external storage. This way pool can be used by multiple application servers. It can be used to store sessions for external services.
desc

end
