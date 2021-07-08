class SubjectTutorsController < ApplicationController

  before_action :authenticate_user!
  authorize_resource

  def index
    render json: JSONAPI::ResourceSerializer.new(
        SubjectTutorResource,
        { include: ['subject', 'tutor'] }
      ).serialize_to_hash(
        current_user.subject_tutors.map{|st| SubjectTutorResource.new(st, nil) }
      )
  end

  def create
    subject_tutor = SubjectTutor.create(subject_tutor_params)
    
    if authorize!(:create, subject_tutor) && subject_tutor.valid?
      render json: subject_tutor
    else
      render json: subject_tutor.errors.messages, status: 422
    end
  end

  def destroy
    subject_tutor = SubjectTutor.find params[:id]
    subject_tutor.destroy if authorize! :destroy, subject_tutor
    render json: subject_tutor
  end

  private

  def subject_tutor_params
    params.require(:subject_tutor).permit(:subject_id, :tutor_id)
  end

end