$:.push File.expand_path("../lib", __FILE__)
require 'socket.io/version'

Gem::Specification.new do |s|
  s.name = 'socket.io'
  s.version = SocketIo::VERSION
  s.platform = Gem::Platform::RUBY
  s.date = '2011-11-21'
  s.authors = ['Derek Kastner']
  s.email = 'dkastner@gmail.com'
  s.homepage = 'http://github.com/dkastner/socket.io-ruby'
  s.summary = %Q{A ruby implementation of a Socket.io-compliant websocket server}
  s.description = %Q{A plugin for Cramp that enables websockets using the Socket.io protocol}
  s.extra_rdoc_files = [
    'LICENSE',
    'README.markdown',
  ]

  s.required_rubygems_version = Gem::Requirement.new('>= 1.3.7')
  s.rubygems_version = '1.3.7'
  s.specification_version = 3

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ['lib']


  s.add_dependency 'cramp', '~> 0.15.1'
  s.add_dependency 'uuid'

  s.add_development_dependency 'bueller'
  s.add_development_dependency 'bundler'
  s.add_development_dependency 'rake'
  s.add_development_dependency 'rcov'
  s.add_development_dependency 'rspec'
end
