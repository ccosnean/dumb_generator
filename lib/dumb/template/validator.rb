module Dumb
    module Template
        class Validator
            attr_reader :templates_path, :template_name

            def initialize(templates_path, template_name)
                @templates_path = templates_path
                @template_name = template_name
            end

            def validate!
                validate_template_exists!
            end

            private
            def validate_template_exists!
                # add contents validators
                linker_missing = !File.exist?("#{templates_path}/#{template_name}/linker.yml")
                variables_missing = !File.exist?("#{templates_path}/#{template_name}/variables.yml")
                root_missing = !File.directory?("#{templates_path}/#{template_name}/root")

                if linker_missing or variables_missing or root_missing
                    print ".dumb_templates/#{template_name}: Invalid template format. Should be:\n\n"
                    print "#{template_name}\n"
                    print "├──root/\n├──linker.yml\n└──variables.yml\n\n"
                    exit
                end
                
            end
        end
    end
end