class StudentSubject < ApplicationRecord

  belongs_to :student, inverse: :student_subjects
  belongs_to :subject, inverse: :student_subjects
end