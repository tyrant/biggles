class SubjectTutor < ApplicationRecord

  belongs_to :subject, inverse: :subject_tutors
  belongs_to :tutor, inverse: :subject_tutors
end