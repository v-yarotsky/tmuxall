require 'rubygems'
require 'test/unit'
$:.unshift File.expand_path('../../lib', __FILE__)

module FakeTmux
  attr_reader :tmux_commands

  def initialize(*args)
    super
    @tmux_commands = StringIO.new
  end

  def tmux(cmd)
    @tmux_commands.puts cmd
  end
end

class TmuxallTestCase < Test::Unit::TestCase
  def default_test
    # Make Test::Unit happy...
  end

  def self.test(name, &block)
    raise ArgumentError, "Example name can't be empty" if String(name).empty?
    block ||= proc { skip "Not implemented yet" }
    define_method "test #{name}", &block
  end

  def stub_env(env)
    old_env = {}
    env.each { |k, v| old_env[k] = ENV[k]; ENV[k] = v }
    yield
    old_env.each { |k, v| ENV[k] = v }
  end
end

