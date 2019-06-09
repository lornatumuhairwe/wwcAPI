module ExceptionHandler
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordInvalid do |exception|
      render json: {error: exception.message}, status: :unprocessable_entity
    end

    rescue_from ActiveRecord::RecordNotFound do |exception|
      render json: {error: exception.message}, status: :not_found
    end
  end
end
