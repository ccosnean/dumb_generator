require 'fileutils'

module Dumb
  module Template
    module Linker
      class FileCreator
        attr_reader :path, :content

        def initialize(path, content)
          @path     = path
          @content  = content
        end

        def execute
          safe_create_hierarchy

          File.open(path, 'w') { |file| file.write(content) }
        end

        private

        def safe_create_hierarchy
          file_dirname = File.dirname(path)

          unless File.directory?(file_dirname)
            FileUtils.mkdir_p(file_dirname)
          end
        end
      end
    end
  end
end