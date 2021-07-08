class ApplicationController < ActionController::API
  
  respond_to :json

  rescue_from CanCan::AccessDenied do |e|
    render json: e.message, status: 403
  end


  private


  def _instance_or_enumerable_of?(candidate, klass)
    candidate.is_a?(klass) || (candidate.respond_to?(:all?) && candidate.all?{|c| c.is_a?(klass) })
  end
end
