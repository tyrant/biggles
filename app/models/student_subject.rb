class StudentSubject < ApplicationRecord

  belongs_to :student, inverse_of: :student_subjects
  belongs_to :subject, inverse_of: :student_subjects

  def as_json(params={})
    {
      id: 'id',
      type: 'student_subjects',
      attributes: {},
      relationships: {
        student: {
          data: {
            id: student.id,
            type: 'students',
          }
        },
        subject: {
          data: {
            id: subject.id,
            type: 'subjects'
          }
        }
      }
    }
  end
end