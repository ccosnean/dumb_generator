require_relative 'template_config_assembler'
require_relative '../input/validator'
require_relative '../template/linker/base'

module Dumb
    module Generator
        class Runner
            attr_reader :arguments

            def initialize(arguments)
                @arguments = arguments
            end

            def execute!
                config = TemplateConfigAssembler.new(arguments).execute!

                arguments.delete('template')
                Dumb::Input::ArgumentVariablesValidator.new(arguments, config).validate!

                Dumb::Template::Linker::Base.new(config, arguments).execute!
            end
        end
    end
end