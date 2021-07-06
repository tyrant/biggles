class SubjectResource < JSONAPI::Resource

  attributes :name

  has_many :student_subjects
  has_many :student_tutors
end
