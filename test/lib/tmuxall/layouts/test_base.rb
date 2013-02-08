require 'test_helper'
require 'tmuxall/layouts/base'
require 'stringio'
require 'ostruct'

include Tmuxall::Layouts

class TestBase < TmuxallTestCase
  class FakeBase < Base
    include FakeTmux

    def create_panes
      tmux "create_panes"
    end

    def run_commands_in_panes
      tmux "run_commands_in_panes"
    end
  end

  def new_layout(*args)
    FakeBase.new(*args)
  end

  test "#raises if no commands given" do
    assert_raise ArgumentError, "No commands to run" do
      new_layout([])
    end
  end

  test "#run does not raise if run in tmux session" do
    stub_env("TMUX" => "true") do
      assert_nothing_raised RuntimeError do
        new_layout(["echo 1"]).run
      end
    end
  end

  test "#run raises if not in tmux session" do
    stub_env("TMUX" => nil) do
      assert_raise RuntimeError, "Must be run in tmux session" do
        new_layout(["echo 1"]).run
      end
    end
  end

  test "#run creates a window with name given in options" do
    layout = new_layout(["echo 1"], OpenStruct.new(:window_name => "testwindow"))
    layout.run
    assert_match /new-window -n testwindow/, layout.tmux_commands.string
  end

  test "#run creates a window with default name" do
    layout = new_layout(["echo 1"])
    layout.run
    assert_match /new-window -n tmuxall/, layout.tmux_commands.string
  end

  test "#run runs commands in correct order" do
    layout = new_layout(["echo 1"])
    layout.run
    assert_equal <<-COMMANDS.lstrip, layout.tmux_commands.string
new-window -n tmuxall
create_panes
run_commands_in_panes
    COMMANDS
  end
end



