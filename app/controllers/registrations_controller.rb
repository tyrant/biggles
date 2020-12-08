class RegistrationsController < Devise::RegistrationsController

  def create
    build_resource(sign_up_params)

    resource.save
    render_resource(resource)
  end

  protected

  def sign_up_params
    params.require(:user).permit(:username, :email, :password, :name, :last_seen, :sex, :age)
  end

end