class SavedProfilesController < ApplicationController

  before_action :authenticate_user!
  authorize_resource

  def index
    render json: _serialized!(current_user.saved_profiles)
  end

  def create
    saved_profile = SavedProfile.create(saved_profile_params)
    
    if authorize!(:create, saved_profile) && saved_profile.valid?
      render json: _serialized!(saved_profile)
    else
      render json: saved_profile.errors.messages, status: 422
    end
  end

  def destroy
    saved_profile = SavedProfile.find params[:id]
    saved_profile.destroy if authorize! :destroy, saved_profile
    render json: _serialized!(saved_profile)
  end

  private

  def saved_profile_params
    params.require(:saved_profile).permit(:saver_id, :savee_id)
  end

  def _serialized!(records)
    unless _instance_or_enumerable_of?(records, SavedProfile)
      raise "Oh come on, just a SavedProfile or an enumerable collection of them, please"
    end

    # The ResourceSerializer accepts either a *_Resource or an
    # array of them. Generate one or the other from our input
    # SavedProfile or array.
    saved_profile_resources = if records.is_a?(SavedProfile)
      SavedProfileResource.new(records, nil)
    else
      records.map{|lu| SavedProfileResource.new(lu, nil) }
    end

    JSONAPI::ResourceSerializer.new(
        SavedProfileResource,
        { include: ['saver', 'savee'] }
      ).serialize_to_hash(saved_profile_resources)
  end
end