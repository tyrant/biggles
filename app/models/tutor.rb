class Tutor < User

  has_many :saved_profiles, inverse_of: :savee
  has_many :saved_students, through: :saved_profile, inverse_of: :saved_tutors
  has_many :subject_tutors, inverse_of: :tutor
  has_many :subjects, through: :subject_tutors, inverse_of: :tutors
  has_many :reviews, inverse_of: :reviewee
end