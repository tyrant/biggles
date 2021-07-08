class SubjectTutorsController < ApplicationController

  before_action :authenticate_user!
  authorize_resource

  def index
    render json: _serialized!(current_user.subject_tutors)
  end

  def create
    subject_tutor = SubjectTutor.create(subject_tutor_params)
    
    if authorize!(:create, subject_tutor) && subject_tutor.valid?
      render json: _serialized!(subject_tutor)
    else
      render json: subject_tutor.errors.messages, status: 422
    end
  end

  def destroy
    subject_tutor = SubjectTutor.find params[:id]
    subject_tutor.destroy if authorize! :destroy, subject_tutor
    render json: _serialized!(subject_tutor)
  end

  private

  def subject_tutor_params
    params.require(:subject_tutor).permit(:subject_id, :tutor_id)
  end


  def _serialized!(records)
    unless _instance_or_enumerable_of?(records, SubjectTutor)
      raise "Oh come on, just a SubjectTutor or an enumerable collection of them, please"
    end

    # The ResourceSerializer accepts either a *_Resource or an
    # array of them. Generate one or the other from our input
    # SubjectTutor or array.
    subject_tutor_resources = if records.is_a?(SubjectTutor)
      SubjectTutorResource.new(records, nil)
    else
      records.map{|r| SubjectTutorResource.new(r, nil) }
    end

    JSONAPI::ResourceSerializer.new(
        SubjectTutorResource,
        { include: ['subject', 'tutor'] }
      ).serialize_to_hash(subject_tutor_resources)
  end
end