require 'yaml'

module Dumb
  module Input
  	class ArgumentVariablesValidator
      attr_reader :variables, :defined_variables

      UNKNOWN_VARIABLE_ERROR = 'Unkown variable `%s`'
      MISSING_VARIABLES_ERROR = 'Missing variables %s'

      def initialize(variables, config)
        @variables = variables
        @config = config

        @defined_variables = YAML.load(
          File.read(@config[:variables_path])
        ).to_h['variables']
      end

      def validate!
        validate_existing_variables!

        validate_missing_variables!
      end

      private

      def validate_existing_variables!
        variables.keys.each do |variable|
          if !defined_variables.include?(variable)
            print "Unknown variable: #{variable} in:\n"
            print UNKNOWN_VARIABLE_ERROR % [variable]

            exit
          end
        end
      end

      def validate_missing_variables!
        if !missing_variables?
          print "Missing variables: #{defined_variables - variables.keys}\n"
          exit
        end
      end

      def missing_variables?
        defined_variables & variables.keys == defined_variables
      end
  	end
  end
end
