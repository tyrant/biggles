class Student < User

  has_many :saved_profiles, inverse_of: :saver
  has_many :saved_tutors, through: :saved_profile, inverse_of: :saved_students
  has_many :student_subjects, inverse_of: :student
  has_many :subjects, through: :student_subject, inverse_of: :students
  has_many :reviews, inverse_of: :student
end