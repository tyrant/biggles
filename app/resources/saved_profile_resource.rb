class SavedProfileResource < JSONAPI::Resource

  attributes :created_at, :updated_at

  has_one :saver,
    class_name: 'Student',
    foreign_key: :saver_id
  has_one :savee,
    class_name: 'Tutor',
    foreign_key: :savee_id
    
end