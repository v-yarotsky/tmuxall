require 'ostruct'

module Tmuxall
  module Layouts

    class Base
      def initialize(commands, options = OpenStruct.new)
        @commands = Array(commands)

        if @commands.empty?
          raise ArgumentError, "No commands to run"
        end

        @options = options
        @panes_count = @commands.size
      end

      def run
        ensure_tmux
        create_window
        create_panes
        run_commands_in_panes
      end

      private

      def ensure_tmux
        if ENV["TMUX"].nil?
          raise "Must be run in tmux session"
        end
      end

      def create_window
        name = @options.window_name || "tmuxall"
        tmux "new-window -n #{name}"
      end

      def create_panes
        raise NotImplementedError
      end

      def run_commands_in_panes
        raise NotImplementedError
      end

      def tmux(cmd)
        @options.dry_run ? puts(cmd) : `tmux #{cmd}`
      end
    end

  end
end
