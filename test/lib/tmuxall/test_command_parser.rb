require 'test_helper'
require 'tmuxall/command_parser'
require 'stringio'

include Tmuxall

class TestCommandParser < TmuxallTestCase
  def new_parser(*args)
    CommandParser.new(*args)
  end

  test "#parse returns arguments passed through ARGV if available" do
    assert_equal ["hello"], new_parser(["hello"], StringIO.new).parse_commands
  end

  test "#parse returns commands from STDIN if no commands passed via ARGV" do
    assert_equal ["hello"], new_parser([], StringIO.new("hello\n")).parse_commands
  end

  test "#parse parses multiline commands passed via STDIN" do
    stdin = StringIO.new(<<-COMMANDS.lstrip)
ls \
-l \
-a
echo test
    COMMANDS
    assert_equal ["ls -l -a", "echo test"], new_parser([], stdin).parse_commands
  end
end




