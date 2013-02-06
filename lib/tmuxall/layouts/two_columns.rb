require 'tmuxall/layouts/base'

module Tmuxall
  module Layouts

    class TwoColumns < Base
      def create_panes
        (1..(@panes_count - 2)).step(2).each do |n|
          tmux "splitw"
          tmux "selectl even-vertical"
        end

        if @panes_count > 1
          (1...@panes_count).step(2).each do |n|
            tmux "selectp -t #{n}"
            tmux "splitw -h"
          end
        end
      end

      def run_commands_in_panes
        (1..@panes_count).each do |n|
          tmux "selectp -t #{n}"
          tmux %Q{send-keys "#{@commands[n - 1]}\n"}
        end
      end
    end

  end
end

