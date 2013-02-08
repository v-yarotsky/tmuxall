require 'test_helper'
require 'tmuxall/layouts/two_columns'
require 'stringio'

include Tmuxall::Layouts

class TestTwoColumns < TmuxallTestCase
  class FakeTwoColumns < TwoColumns
    include FakeTmux
  end

  def new_layout(*args)
    FakeTwoColumns.new(*args)
  end

  test "#create_panes with one pane does not split" do
    layout = new_layout("echo hello")
    layout.create_panes
    assert_equal "", layout.tmux_commands.string
  end

  test "#create_panes with two panes splits vertically" do
    layout = new_layout(["echo 1", "echo 2"])
    layout.create_panes
    assert_equal <<-COMMANDS.lstrip, layout.tmux_commands.string
selectp -t 1
splitw -h
    COMMANDS
  end

  test "#create_panes with three panes splits vertically then horizontally" do
    layout = new_layout(["echo 1", "echo 2", "echo 3"])
    layout.create_panes
    assert_equal <<-COMMANDS.lstrip, layout.tmux_commands.string
splitw
selectl even-vertical
selectp -t 1
splitw -h
    COMMANDS
  end

  test "#create_panes with four panes splits to four parts" do
    layout = new_layout(["echo 1", "echo 2", "echo 3", "echo 4"])
    layout.create_panes
    assert_equal <<-COMMANDS.lstrip, layout.tmux_commands.string
splitw
selectl even-vertical
selectp -t 1
splitw -h
selectp -t 3
splitw -h
    COMMANDS
  end

  test "#run_commands_in_panes runs single command in first pane" do
    layout = new_layout(["echo 1"])
    layout.run_commands_in_panes
    assert_equal <<-COMMANDS.lstrip, layout.tmux_commands.string
selectp -t 1
send-keys "echo 1\n"
    COMMANDS
  end

  test "#run_commands_in_panes runs commands in sequential panes" do
    layout = new_layout(["echo 1", "echo 2"])
    layout.run_commands_in_panes
    assert_equal <<-COMMANDS.lstrip, layout.tmux_commands.string
selectp -t 1
send-keys "echo 1\n"
selectp -t 2
send-keys "echo 2\n"
    COMMANDS
  end
end


