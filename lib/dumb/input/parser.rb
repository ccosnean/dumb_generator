module Dumb
  module Input
    module Parser
      def self.commands
        passed_commands = ARGV.select { |a| !a.include?(':') }

        if (passed_commands.length > 1)
          print "dumb_generator: too many commands, run one at a time\n"
          exit
        end

        available_commands = ["run", "init", "help"]
        passed_command = passed_commands.first || "run"

        if !available_commands.include?(passed_command)
          print "dumb_generator: command `#{passed_command}` not found in:\n#{available_commands}\n"
          exit
        end

        arguments = ARGV.each_with_object({}) do |argument_variable, memo|
          var_name = argument_variable.split(':').first
          var_value = argument_variable.split(':').last

          memo[var_name] = var_value
        end

        {
          command: passed_command,
          arguments: arguments,
        }
      end
    end
  end
end