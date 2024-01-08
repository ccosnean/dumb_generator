require 'yaml'

require_relative 'content_parser'
require_relative 'path_parser'
require_relative 'file_creator'

module Dumb
  module Template
    module Linker
      class Base
        attr_reader :config, :variables

        def initialize(config, variables)
          @config     = config
          @variables  = variables
        end

        def execute!
          root = dgen_linker['root']
          dgen_source_directory = root['dgen_source_directory']
          link_destination_directory = root['link_destination_directory']
          links = root['links']
          template_full_path = config[:template_path]


          
          links.each do |link|
            link.transform_keys!(&:to_sym)
            
            file_path = template_full_path + '/' + link_destination_directory + '/' + link[:to_destination_file]
            template_path = template_full_path + '/' + dgen_source_directory + '/' + link[:dgen_template]
            
            parsed_path = PathParser.new(file_path, variables).parse
            parsed_templete_path = PathParser.new(template_path, variables).parse
            
            template_content = File.read(parsed_templete_path)
            parsed_content = ContentParser.new(template_content, variables).parse

            FileCreator.new(parsed_path, parsed_content).execute
          end
        end

        private

        def dgen_linker
          YAML.load(File.read(config[:linker_path])).to_h
        end
      end
    end
  end
end