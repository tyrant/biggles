class StudentSubjectsController < ApplicationController

  before_action :authenticate_user!
  authorize_resource

  def index
    render json: _serialized!(current_user.student_subjects)
  end

  def create
    student_subject = StudentSubject.create(student_subject_params)
    
    if authorize!(:create, student_subject) && student_subject.valid?
      render json: _serialized!(student_subject)
    else
      render json: student_subject.errors.messages, status: 422
    end
  end

  def destroy
    student_subject = StudentSubject.find params[:id]
    student_subject.destroy if authorize! :destroy, student_subject
    render json: _serialized!(student_subject)
  end

  private

  def student_subject_params
    params.require(:student_subject).permit(:student_id, :subject_id)
  end


  def _serialized!(records)
    unless _instance_or_enumerable_of?(records, StudentSubject)
      raise "Oh come on, just a StudentSubject or an enumerable collection of them, please."
    end

    # The ResourceSerializer accepts either a *_Resource or an
    # array of them. Generate one or the other from our input
    # StudentSubject or array.
    student_subject_resources = if records.is_a?(StudentSubject)
      StudentSubjectResource.new(records, nil)
    else
      records.map{|r| StudentSubjectResource.new(r, nil) }
    end

    JSONAPI::ResourceSerializer.new(
        StudentSubjectResource,
        { include: ['student', 'subject'] }
      ).serialize_to_hash(student_subject_resources)
  end
end