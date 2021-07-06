class PostcodeResource < JSONAPI::Resource

  attributes :code, :county, :latitude, :longitude, :name, :state, :created_at, :updated_at
  
  has_many :users

end