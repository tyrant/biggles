class SubjectTutorResource < JSONAPI::Resource

  attributes :created_at, :updated_at

  has_one :subject, always_include_linkage_data: true
  has_one :tutor, always_include_linkage_data: true
end
