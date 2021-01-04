require 'rails_helper'

describe 'POST /signup', type: :request do
  
  let(:tutor_attrs) { attributes_for :tutor }
  let(:postcode) { create :postcode }
  let(:profile_image_datastring) {
    image = File.open(Rails.root.join('spec', 'support', 'assets', 'austin-powers-headshot.jpeg'), 'rb').read

    "data:image/jpeg;base64,#{Base64.encode64(image)}"
  }

  let(:params) { 
    { 
      user: {
        email: tutor_attrs[:email],
        password: tutor_attrs[:password],
        password_confirmation: tutor_attrs[:password],
        first_name: tutor_attrs[:first_name],
        last_name: tutor_attrs[:last_name],
        last_seen: tutor_attrs[:last_seen],
        sex: tutor_attrs[:sex],
        age: tutor_attrs[:age],

        city: tutor_attrs[:city],

        postcode: { id: postcode.id },

        subject: tutor_attrs[:subject],
        biography: tutor_attrs[:biography],
        hourly_rate: tutor_attrs[:hourly_rate],
        max_distance_available: tutor_attrs[:max_distance_available],
        profile_image: profile_image_datastring
      }
    }
  }
  context "correct params" do

    before {
      post '/signup', params: params 
    }



    it { expect(response).to have_http_status(200) }

    it "saves and returns the email" do
      expect(response_json['attributes']['email']).to eq tutor_attrs[:email]
    end

    it "saves and returns the first_name" do
      expect(response_json['attributes']['first_name']).to eq tutor_attrs[:first_name]
    end

    it "saves and returns the last_name" do
      expect(response_json['attributes']['last_name']).to eq tutor_attrs[:last_name]
    end

    it "saves and returns last_seen (sidestep format issues by comparing both timestamps)" do
      expect(Time.parse(response_json['attributes']['last_seen']).to_i).to eq tutor_attrs[:last_seen].to_i
    end

    it "saves and returns the sex" do
      expect(response_json['attributes']['sex']).to eq tutor_attrs[:sex]
    end

    it "saves and returns the age" do
      expect(response_json['attributes']['age']).to eq tutor_attrs[:age]
    end

    it "saves and returns the hourly_rate" do
      expect(response_json['attributes']['hourly_rate'].to_f).to eq tutor_attrs[:hourly_rate]
    end

    it "saves and returns the max_distance_available" do
      expect(response_json['attributes']['max_distance_available'].to_f).to eq tutor_attrs[:max_distance_available]
    end

    it "saves and returns the biography" do
      expect(response_json['attributes']['biography']).to eq tutor_attrs[:biography]
    end


  end

  context "incorrect params" do

  end

  it "increments the uploaded-file count" do
    f = fixture_file_upload(Rails.root.join('spec', 'support', 'assets', 'austin-powers-headshot.jpeg'), 'image/jpeg')

    expect {
      post '/signup', params: params
    }.to change(ActiveStorage::Attachment, :count).by(1)
  end
end