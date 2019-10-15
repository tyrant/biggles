class Subject < ApplicationRecord

  has_many :student_subjects, inverse: :subject
  has_many :students, through: :student_subject, inverse: :subjects
  has_many :subject_tutors, inverse: :subject
  has_many :tutors, through: :subject_tutor, inverse: :subjects
end