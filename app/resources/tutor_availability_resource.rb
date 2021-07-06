class TutorAvailabilityResource < JSONAPI::Resource

  attributes :created_at, :updated_at

  has_one :tutor, always_include_linkage_data: true
  has_one :availability, always_include_linkage_data: true

end