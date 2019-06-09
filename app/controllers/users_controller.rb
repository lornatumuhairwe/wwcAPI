class UsersController < ApplicationController
  skip_before_action :authenticate

  def generate_api_key
    user = User.create!(user_params)
    json_response(user, :created)
  end

  private

  def user_params
    params.permit(:email)
  end
end
