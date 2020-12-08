require 'rails_helper'

describe 'POST /signup', type: :request do
  
  let(:user_attrs) { attributes_for :user }

  before { post '/signup', params: params }

  context "correct params" do

    let(:params) { 
      { 
        user: {
          email:                 user_attrs[:email],
          password:              user_attrs[:password],
          password_confirmation: user_attrs[:password],
          name:                  user_attrs[:name],
          last_seen:             user_attrs[:last_seen],
          sex:                   user_attrs[:sex],
          age:                   user_attrs[:age]
        } 
      }
    }

    it { expect(response).to have_http_status(200) }

    it "saves and returns the email" do
      expect(response_json['attributes']['email']).to eq user_attrs[:email]
    end

    it "saves and returns the name" do
      expect(response_json['attributes']['name']).to eq user_attrs[:name]
    end

    it "saves and returns last_seen (sidestep format issues by comparing both timestamps)" do
      expect(Time.parse(response_json['attributes']['last_seen']).to_i).to eq user_attrs[:last_seen].to_i
    end

    it "saves and returns the sex" do
      expect(response_json['attributes']['sex']).to eq user_attrs[:sex]
    end

    it "saves and returns the age" do
      expect(response_json['attributes']['age']).to eq user_attrs[:age]
    end
  end

  context "incorrect params" do

  end
end