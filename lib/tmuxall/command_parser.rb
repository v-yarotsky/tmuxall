module Tmuxall

  class CommandParser
    def initialize(argv, stdin)
      @argv = Array(argv)
      @stdin = stdin
    end

    def parse_commands
      Array(@argv).empty? ? parse_stdin_commands(@stdin)
                          : parse_argv_commands(@argv)
    end

    private

    def parse_stdin_commands(stdin)
      commands = []
      buffer = ""
      stdin.each_line do |line|
        if line =~ /\\$/
          buffer << line
          next
        end
        buffer << line.rstrip
        commands << buffer.dup
        buffer.clear
      end
      commands
    end

    def parse_argv_commands(argv)
      argv
    end
  end

end

