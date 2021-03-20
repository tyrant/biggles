class RegistrationsController < Devise::RegistrationsController

  def create
    build_resource(user_params)
    
    if user_params.key? :profile_image
      resource.profile_image.attach(data: user_params[:profile_image])
    end

    resource.save
    render_resource(resource)
  end

  protected

  def user_params
    params.require(:user)
      .permit(:email, :password, :password_confirmation, :first_name, :last_name, 
              :last_seen, :sex, :age, :biography, :hourly_rate, 
              :max_distance_available, :profile_image, :type)
  end

end