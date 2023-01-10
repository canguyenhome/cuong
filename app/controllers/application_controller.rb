class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  class QueryError < StandardError; end
  
  def query(definition, variables = {})
      response = Cuong::Client.query(definition, variables: variables, context: client_context)

      if response.errors.any?
        raise QueryError.new(response.errors[:data].join(", "))
      else
        response.data
      end
    end
    
    def client_context
      # Use static access token from environment. However, here we have access
      # to the current request so we could configure the token to be retrieved
      # from a session cookie.
      { access_token: Cuong::Application.secrets.github_access_token }
    end
end
