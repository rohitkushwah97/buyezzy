# frozen_string_literal: true
require_relative "rails_helper"
require "rswag"

module AccountBlockSwaggerHelper
  def self.swagger_docs
    {"v1/swagger.json"=>
      {:openapi=>"3.0.3",
       :info=>
        {:title=>"account_block",
         :version=>"1.0.0",
         :description=>"Account block API"},
       :servers=>[{:url=>"http://localhost:3000"}],
       :components=>
        {:schemas=>
          {:email_account=>
            {:type=>:object,
             :properties=>
              {:id=>{:type=>:string, :nullable=>false, :example=>"1"},
               :type=>
                {:type=>:string, :nullable=>false, :example=>"email_account"},
               :attributes=>
                {:type=>:object,
                 :properties=>
                  {:id=>{:type=>:string, :nullable=>false, :example=>"1"},
                   :email=>
                    {:type=>:string, :nullable=>true, :example=>"test@gmail.com"},
                   :first_name=>
                    {:type=>:string, :nullable=>true, :example=>"test"},
                   :last_name=>{:type=>:string, :nullable=>true, :example=>"test"},
                   :full_phone_number=>
                    {:type=>:string, :nullable=>true, :example=>"test"},
                   :type=>{:type=>:string, :nullable=>true, :example=>"admin"},
                   :password=>{:type=>:string, :nullable=>true, :example=>"test"},
                   :activated=>
                    {:type=>:boolean, :nullable=>true, :example=>"true"},
                   :device_id=>{:type=>:integer, :nullable=>true, :example=>"123"},
                   :unique_auth_id=>
                    {:type=>:string,
                     :nullable=>true,
                     :example=>"i8vXRD10xmBUXiJ6pA667Qtt"},
                   :country_code=>
                    {:type=>:string, :nullable=>true, :example=>"91"},
                   :created_at=>
                    {:type=>:string,
                     :format=>:datetime,
                     :nullable=>true,
                     :example=>"2022-12-17 10:29:55"},
                   :updated_at=>
                    {:type=>:string,
                     :format=>:datetime,
                     :nullable=>true,
                     :example=>"2022-12-17 10:29:55"}}}}},
           :sms_account=>
            {:type=>:object,
             :properties=>
              {:id=>{:type=>:string, :nullable=>false, :example=>"1"},
               :type=>{:type=>:string, :nullable=>false, :example=>"sms_account"},
               :attributes=>
                {:type=>:object,
                 :properties=>
                  {:id=>{:type=>:string, :nullable=>false, :example=>"1"},
                   :full_phone_number=>
                    {:type=>:string, :nullable=>true, :example=>"test"},
                   :password=>{:type=>:string, :nullable=>true, :example=>"test"},
                   :created_at=>
                    {:type=>:string,
                     :format=>:datetime,
                     :nullable=>true,
                     :example=>"2022-12-17 10:29:55"},
                   :updated_at=>
                    {:type=>:string,
                     :format=>:datetime,
                     :nullable=>true,
                     :example=>"2022-12-17 10:29:55"}}}}}}}}}
  end
end

# Protected Area Start
RSpec.configure do |config|
  config.swagger_root = Rails.root.join('swagger').to_s
  config.swagger_format = :json

  unless ENV['RSPEC_APP_SOURCE'] == 'client_app'
    config.swagger_docs = AccountBlockSwaggerHelper.swagger_docs
  end
end
# Protected Area End
