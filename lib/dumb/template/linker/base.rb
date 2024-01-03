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
          link_destination_directory = root['link_destination_directory']
          links = root['links']
          template_path = config[:template_path]

          links.each do |link|
            link.transform_keys!(&:to_sym)

            file_path = template_path + '/' + link_destination_directory + '/' + link[:to_destinaiton_file]
            template_content = File.read(config[:root_path] + '/' + link[:dgen_template])

            parsed_path = PathParser.new(file_path, variables).parse
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