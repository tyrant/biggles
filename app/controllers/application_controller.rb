class ApplicationController < ActionController::API
  
  respond_to :json

  def render_resource(resource)

    if resource.errors.empty?
      render json: resource
    else
      render json: {
        errors: [{
          status: '400',
          title: 'Bad Request',
          detail: resource.errors,
          code: '100'
        }],
      }, status: :bad_request
    end
  end

  rescue_from CanCan::AccessDenied do |e|
    render json: e.message, status: 403
  end
end
