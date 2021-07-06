class LanguageUserResource < JSONAPI::Resource

  attributes :created_at, :updated_at
  
  has_one :language
  has_one :user
  
end