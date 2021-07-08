class LanguageUsersController < ApplicationController

  before_action :authenticate_user!
  authorize_resource

  # GET /language_users
  def index
    render json: _serialized!(current_user.language_users)
  end

  def create
    language_user = LanguageUser.create(language_user_params)
    
    if authorize!(:create, language_user) && language_user.valid?
      render json: _serialized!(language_user)
    else
      render json: language_user.errors.messages, status: 422
    end
  end

  def destroy
    language_user = LanguageUser.find params[:id]
    language_user.destroy if authorize! :destroy, language_user
    render json: _serialized!(language_user)
  end


  private


  def language_user_params
    params.require(:language_user).permit(:language_id, :user_id)
  end

  # Receives either a LanguageUser or an array of 'em, and throws them
  # through jsonapi-resources serialization.
  def _serialized!(records)
    unless _instance_or_enumerable_of?(records, LanguageUser)
      raise "Oh come on, just a LanguageUser or an enumerable collection of them, please"
    end

    # The ResourceSerializer accepts either a *_Resource or an
    # array of them. Generate one or the other from our input
    # LanguageUser or array.
    language_user_resources = if records.is_a?(LanguageUser)
      LanguageUserResource.new(records, nil)
    else
      records.map{|lu| LanguageUserResource.new(lu, nil) }
    end

    JSONAPI::ResourceSerializer.new(
        LanguageUserResource,
        { include: ['language', 'user'] }
      ).serialize_to_hash(language_user_resources)
  end
end