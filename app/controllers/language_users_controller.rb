class LanguageUsersController < ApplicationController

  before_action :authenticate_user!
  authorize_resource

  def index
    render json: current_user.language_users
  end

  def create
    language_user = LanguageUser.create(language_user_params)
    
    if authorize!(:create, language_user) && language_user.valid?
      render json: language_user
    else
      render json: language_user.errors.messages, status: 422
    end
  end

  def destroy
    language_user = LanguageUser.find params[:id]
    language_user.destroy if authorize! :destroy, language_user
    render json: language_user
  end

  private

  def language_user_params
    params.require(:language_user).permit(:language_id, :user_id)
  end

end