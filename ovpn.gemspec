# coding: utf-8
lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)
require 'ovpn'

spec = Gem::Specification.new do |s|
  s.name = 'ovpn'
  s.licenses = ['MPLv2']
  s.version = OpenVPN::VERSION
  s.platform = Gem::Platform::RUBY
  s.summary = "manage openvpn profiles"
  s.description = s.summary
  s.author = "Dominik Richter"
  s.email = "dominik.richter@googlemail.com"

  s.files = `git ls-files`.split("\n")
  s.executables = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
