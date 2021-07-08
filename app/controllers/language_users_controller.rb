class LanguageUsersController < ApplicationController

  before_action :authenticate_user!
  authorize_resource

  # GET /language_users
  def index
    render json: JSONAPI::ResourceSerializer.new(
        LanguageUserResource,
        { include: ['language', 'user'] }
      ).serialize_to_hash(
        current_user.language_users.map{|lu| LanguageUserResource.new(lu, nil) }
      )
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