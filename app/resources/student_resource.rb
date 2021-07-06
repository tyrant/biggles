class StudentResource < UserResource

  has_many :saved_profiles,
    foreign_key: :saver_id
  has_many :student_subjects
  has_many :reviews
  
end