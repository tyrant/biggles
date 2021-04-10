require 'rails_helper'

describe User do
  
  let(:postcode) { create :postcode }
  let(:user) { create :user, postcode: postcode }

  describe '#as_json' do

  	it "includes the full Postcode JSON in its JSON response's 'included' key" do
  	  expect(user.as_json[:included]).to include postcode.as_json
  	end
  end
end