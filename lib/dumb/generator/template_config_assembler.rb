require_relative '../template/validator'

module Dumb
    module Generator
        class TemplateConfigAssembler
            attr_reader :arguments

            def initialize(arguments)
                @arguments = arguments
            end

            def execute!
                templates_path = Dir.pwd + '/.dumb_templates'

                if !Dir.exist?(templates_path)
                    print ".dumb_templates: does not exist in current directory.\nrun: $> dgen init\n"
                    exit
                end

                template_names = Dir.entries(templates_path).select do |entry|
                    files = File.directory?(File.join(templates_path, entry))

                    files and !(entry == '.' || entry == '..')
                end

                template_names.each do |template|
                    Dumb::Template::Validator.new(templates_path, template).validate!
                end
                
                selected_template = arguments.key?('template') ? arguments['template'] : nil
                if selected_template.nil?
                    print "dumb_generator: template not specified\n"
                    exit
                end

                if !template_names.include?(selected_template)
                    print "dumb_generator: template `#{selected_template}` not found\nAvailable templates:\n"
                    print "#{template_names}\n"
                    exit
                end

                templates = {} 
                template_names.each do |template|
                    templates[template] = {
                        template_path: "#{templates_path}/#{template}",
                        linker_path: "#{templates_path}/#{template}/linker.yml",
                        variables_path: "#{templates_path}/#{template}/variables.yml"
                    }
                end

                templates[selected_template]
            end
        end
    end
end