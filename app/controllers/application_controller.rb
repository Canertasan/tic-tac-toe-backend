class ApplicationController < ActionController::API
  
  def render_service_errors(service)
    render json: {
      errors: service.errors.uniq.map { |error| { detail: error } }
    }, status: :unprocessable_entity
  end
end
