class ApplicationController < ActionController::API
  
  def render_service_errors(service)
    render json: { base: service.errors.uniq }, status: 422
  end
end
