class Postcode < ApplicationRecord

  has_many :users, inverse_of: :postcodes

  acts_as_mappable lat_column_name: :latitude, 
                   lng_column_name: :longitude

  def as_json(params={})
  	{
  	  data: {
	  	  id: id,
	  	  type: 'postcodes',
	  	  attributes: { 
		      code: code,
		      county: county,
		      latitude: latitude,
		      longitude: longitude,
		      name: name,
		      state: state
        }
	    }
    }
  end
end