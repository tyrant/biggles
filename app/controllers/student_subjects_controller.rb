class StudentSubjectsController < ApplicationController

  before_action :authenticate_user!
  authorize_resource

  def index
    render json: current_user.student_subjects
  end

  def create
    student_subject = StudentSubject.create(student_subject_params)
    
    if authorize!(:create, student_subject) && student_subject.valid?
      render json: student_subject
    else
      render json: student_subject.errors.messages, status: 422
    end
  end

  def destroy
    student_subject = StudentSubject.find params[:id]
    student_subject.destroy if authorize! :destroy, student_subject
    render json: student_subject
  end

  private

  def student_subject_params
    params.require(:student_subject).permit(:student_id, :subject_id)
  end

end