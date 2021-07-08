class TutorAvailabilitiesController < ApplicationController

  before_action :authenticate_user!
  authorize_resource

  def index
    render json: _serialized!(current_user.tutor_availabilities)
  end

  def create
    tutor_availability = TutorAvailability.create(tutor_availability_params)
    
    if authorize!(:create, tutor_availability) && tutor_availability.valid?
      render json: _serialized!(tutor_availability)
    else
      render json: tutor_availability.errors.messages, status: 422
    end
  end

  def destroy
    tutor_availability = TutorAvailability.find params[:id]
    tutor_availability.destroy if authorize! :destroy, tutor_availability
    render json: _serialized!(tutor_availability)
  end

  private

  def tutor_availability_params
    params.require(:tutor_availability).permit(:tutor_id, :availability_id)
  end

  def _serialized!(records)
    unless _instance_or_enumerable_of?(records, TutorAvailability)
      raise "Oh come on, just a TutorAvailability or an enumerable collection of them, please"
    end

    # The ResourceSerializer accepts either a *_Resource or an
    # array of them. Generate one or the other from our input
    # TutorAvailability or array.
    tutor_availability_resources = if records.is_a?(TutorAvailability)
      TutorAvailabilityResource.new(records, nil)
    else
      records.map{|r| TutorAvailabilityResource.new(r, nil) }
    end

    JSONAPI::ResourceSerializer.new(
        TutorAvailabilityResource,
        { include: ['tutor', 'availability'] }
      ).serialize_to_hash(tutor_availability_resources)
  end
end