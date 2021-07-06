class MessageResource < JSONAPI::Resource

  attributes :content, :seen_at, :created_at, :updated_at

  has_one :messager,
    class_name: 'User',
    foreign_key: :messager_id
  has_one :messagee,
    class_name: 'User',
    foreign_key: :messagee_id
    
end