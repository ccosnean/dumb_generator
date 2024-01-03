module Dumb
  module Template
    module Linker
      class ContentParser
        attr_reader :content, :variables

        MATCH_REGEX = /({{(.*?)}})/.freeze

        def initialize(content, variables)
          @content    = content
          @variables  = variables
        end

        def parse
          template_variables = content.scan(MATCH_REGEX).to_h

          template_variables.each do |full_string, variable_name|
            content.gsub!(full_string, variables[variable_name])
          end

          content
        end
      end
    end
  end
end