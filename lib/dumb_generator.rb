require_relative 'dumb/input/parser'
require_relative 'dumb/generator/runner'
require_relative 'dumb/template/initializer'

module Dumb
	module Generator
		class Base
			def execute!
				commands = Dumb::Input::Parser.commands
				arguments = commands[:arguments]

				if commands[:command] == "run" 
					Dumb::Generator::Runner.new(arguments).execute!
				elsif commands[:command] == "init" 
					Dumb::Template::Initializer.new.execute!
				elsif commands[:command] == "help" 
					print <<-HELP
Usage: dgen [COMMAND] [ARGUMENT_NAME:ARGUMENT_VALUE]

Ex:
$> dgen template:default class_name:MyClass file_name:my_file

Commands:
  run:    run a template (default, if no command is specified)
  init:   initialize the dumb_generator, adds .dumb_templates to current directory and a default template
  help:   show this message

Arguments:
  template:   specify a template to run
HELP
				end
			end
		end
	end
end
