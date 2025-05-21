require 'rails/generators'
require 'rails/generators/active_record'

  module BxBuilderChain
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path('templates', __dir__)

      desc "Creates BxBuilderChain initializer, migration, and copies app templates for your application"

      def copy_initializer
        template "initializer.rb", "config/initializers/bx_builder_chain.rb"
      end

      def copy_migration
        timestamp_number = Time.now.strftime("%Y%m%d%H%M%S")
        template "migration.rb", "db/migrate/#{timestamp_number}_create_bx_builder_chain_schema.rb"
      end

      def copy_app_templates
        directory "app", Rails.root.join("app")
      end

      def add_routes
        inject_into_file 'config/routes.rb', after: "Rails.application.routes.draw do\n" do
          <<~ROUTES
  namespace :bx_builder_chain do
    get 'test_form', to: 'test#form' # remove before production

    post 'documents/upload', to: 'documents#upload_and_process'
    post 'documents/upload_for_later', to: 'documents#upload_and_process_later'
    get 'documents/list', to: 'documents#namespace_documents'
    delete 'documents/delete', to: 'documents#delete_documents'

    post 'ask', to: 'questions#ask'
  end
          ROUTES
        end
      end
    end
  end
