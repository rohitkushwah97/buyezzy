# frozen_string_literal: true

require "builder_base/generators/install/base"

module BxBlockComments
  module Block
    class InstallGenerator < BuilderBase::Generators::Install::Base
      set_file_directory __dir__
      private

      def copy_files
        super

        copy_assets
      end

      def copy_assets
        Array(Dir[File.join(base_path("app/assets"), '**', '*.*')]).each do |file|
          stem = file.gsub(generator_root, '')
          next unless File.exists?(file)
          content = File.read(file)
          create_file stem, content, force: true
        end
      end

    end
  end
end
