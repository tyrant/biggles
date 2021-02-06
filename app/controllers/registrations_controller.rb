class RegistrationsController < Devise::RegistrationsController

  def create
    build_resource(tutor_params)
    
    if tutor_params.key? :profile_image
      resource.profile_image.attach(data: tutor_params[:profile_image])
    end

    resource.save
    render_resource(resource)
  end

  protected

  def tutor_params
    params.require(:user).permit(:email, :password, :password_confirmation, :name, :last_seen, :sex, :age, :biography, :hourly_rate, :max_distance_available, :profile_image)
  end

  def resource_class
    Tutor
  end
end