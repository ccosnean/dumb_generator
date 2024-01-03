module Dumb
  module Template
    module Linker
      class PathParser
        attr_reader :path, :variables

        MATCH_REGEX = /({{(.*?)}})/.freeze

        def initialize(path, variables)
          @path       = path
          @variables  = variables
        end

        def parse
          groups = path.scan(MATCH_REGEX).to_h
          groups.each do |full_string, var_name|
            path.gsub!(full_string, variables[var_name])
          end

          path
        end
      end
    end
  end
end