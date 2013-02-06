# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'tmuxall/version'
require 'date'

Gem::Specification.new do |gem|
  gem.name          = "tmuxall"
  gem.version       = Tmuxall::VERSION
  gem.date          = Date.today.to_s
  gem.authors       = ["Vladimir Yarotsky"]
  gem.email         = ["vladimir.yarotsky@gmail.com"]

  gem.summary       = <<DESC
An utility to launch multiple commands inside tmux session with custom layouts
DESC

  gem.homepage      = "https://github.com/v-yarotsky/tmuxall"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
