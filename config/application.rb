require_relative 'boot'

require 'rails/all'
require 'action_controller/railtie'
require 'action_view/railtie'
require 'graphql/client/railtie'
require 'graphql/client/http'

Bundler.require(*Rails.groups)

module Cuong
  class Application < Rails::Application
  end
  
  HTTP = GraphQL::Client::HTTP.new("https://api.github.com/graphql") do
    def headers(context)
      token = ENV['GITHUB_ACCESS_TOKEN']
      {
        "Authorization" => "Bearer #{token}"
      }
    end
  end

  Client = GraphQL::Client.new(
    schema: Application.root.join("db/schema.json").to_s,
    execute: HTTP
  )
  Application.config.graphql.client = Client
end
