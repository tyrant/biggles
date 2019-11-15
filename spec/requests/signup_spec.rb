require 'rails_helper'

describe 'POST /signup', type: :request do

  let(:url) { '/signup' }
  let(:params) { 
    { user: attributes_for(:user) }
  }

  context "User hasn't authenticated yet" do

    before { post url, params: params }

    it { expect(response.status).to eq 200 }
    it { expect(JSON.parse(response.body)['attributes']['email']).to eq params[:user][:email] }
  end

  context 'User already exists in the database' do

    before {
      create :user, email: params[:user][:email]
      post url, params: params
    }

    it { expect(response.status).to eq 400 }
    it { expect(JSON.parse(response.body)['errors'][0]['title']).to eq('Bad Request') }
  end
end