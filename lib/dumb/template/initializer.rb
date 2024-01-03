module Dumb
    module Template
        class Initializer
            def execute!
                puts 'Initializing dumb_generator...'
                
                # add .dumb_templates folder
                if !File.directory?('.dumb_templates')
                    Dir.mkdir('.dumb_templates')
                    puts 'Created .dumb_templates folder'
                end

                # add default template
                if !File.directory?('.dumb_templates/default')
                    Dir.mkdir('.dumb_templates/default')
                end

                createLinker!
                createVariables!
                createDgenFiles!

                puts 'Done!'
            end

            private

            def createDgenFiles!
                # create root folder
                if !File.directory?('.dumb_templates/default/root')
                    Dir.mkdir('.dumb_templates/default/root')
                end

                # create dgen files
                file = File.new('.dumb_templates/default/root/file.dgen', 'w')
                file.puts <<-TEXT
class {{class_name}}Class {}
TEXT

                file.close

                if !File.directory?('.dumb_templates/default/root/subdir')
                    Dir.mkdir('.dumb_templates/default/root/subdir')
                end

                file = File.new('.dumb_templates/default/root/subdir/file.dgen', 'w')
                file.puts <<-TEXT
class Sub{{class_name}}Class {}
TEXT

                file.close
            end

            def createLinker!
                # create linker.yml
                file = File.new('.dumb_templates/default/linker.yml', 'w')
                file.puts <<-TEXT
# Suports variables defined in variables.yml
# All paths are relative

root:
  link_destination_directory: "../../src/{{file_name}}"
  links:
    - link:
      dgen_template: "subdir/file.dgen"
      to_destinaiton_file: "subdir/{{file_name}}_file.txt"
    - link:
      dgen_template: "file.dgen"
      to_destinaiton_file: "{{file_name}}_file.txt"
TEXT

                file.close
            end

            def createVariables!
                file = File.new('.dumb_templates/default/variables.yml', 'w')
                file.puts <<-TEXT
variables:
  - file_name
  - class_name        
TEXT

                file.close
            end
        end
    end
end