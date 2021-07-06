class StudentSubjectResource < JSONAPI::Resource

  attributes :created_at, :updated_at

  has_one :student
  has_one :subject
end