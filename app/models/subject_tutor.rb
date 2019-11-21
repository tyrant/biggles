class SubjectTutor < ApplicationRecord

  belongs_to :subject, inverse_of: :subject_tutors
  belongs_to :tutor, inverse_of: :subject_tutors

  def as_json(params={})
    {
      id: 'id',
      type: 'subject_tutors',
      attributes: {},
      relationships: {
        subject: {
          data: {
            id: subject.id,
            type: 'subjects',
          }
        },
        tutor: {
          data: {
            id: tutor.id,
            type: 'tutors'
          }
        }
      }
    }
  end
end