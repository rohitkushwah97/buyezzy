# frozen_string_literal: true

require "builder_base/generators/install/base"

module BxBlockChat
  module Block
    class InstallGenerator < BuilderBase::Generators::Install::Base
      set_file_directory __dir__

      def execute
        super

        enable_action_cable
      end

      private

      def enable_action_cable
        delete_lines(
          "config/application.rb",
          [
            '# require "action_cable/engine"'
          ]
        )

        insert_lines(
          "config/application.rb",
          'require "action_view/railtie"',
          [
            'require "action_cable/engine"'
          ]
        )
      end

      def insert_lines(file_name, target_line, new_lines)
        contents = File.read(file_name)
        target_position = if target_line.nil?
          contents.split("\n").count
        else
          contents.split("\n").find_index(target_line) + 1
        end

        new_lines.reverse_each do |line|
          next if contents.include? line
          split_contents = contents.split("\n")
          split_contents.insert(target_position, line)
          contents = split_contents.join("\n")
        end
        File.open(file_name, "w") { |file| file.puts contents }
      end

      def delete_lines(file_name, lines_to_delete)
        contents = File.read(file_name)

        lines_to_delete.each do |line|
          next unless contents.include? line
          split_contents = contents.split("\n")
          split_contents.delete(line)
          contents = split_contents.join("\n")
        end
        File.open(file_name, "w") { |file| file.puts contents }
      end
    end
  end
end
