# coding: utf-8
lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)
require 'ovpn'

require 'rake'
require 'rake/clean'

VERSION = OpenVPN::VERSION
GEMSPEC = 'ovpn.gemspec'
GEM = "ovpn-#{VERSION}.gem"

desc 'Build the gem'
task :build do
  sh "mkdir -p target"
  sh "gem build #{GEMSPEC}"
  sh "mv #{GEM} target/"
end

task :default
