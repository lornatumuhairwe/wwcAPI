class ApplicationController < ActionController::API
  include Response
  include ExceptionHandler
  include ActionController::HttpAuthentication::Token::ControllerMethods

  before_action :authenticate

  def authenticate
    authenticate_api_key || render_unauthorized
  end

  def authenticate_api_key
    authenticate_or_request_with_http_token do |token, options|
      User.find_by(api_key: token)
    end
  end

  def render_unauthorized(realm='Application')
    self.headers['WWW-Authenticate'] = %(Token ream="#{realm}")
    render json: 'Bad credentials', status: :unauthorized
  end
end
