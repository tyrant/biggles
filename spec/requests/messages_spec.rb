require 'rails_helper'

describe "Messages" do

  describe "Yoinking a logged-in user's existing messages" do

    let!(:users) { create_list :user, 2 }
    let!(:messages_from0to1) { 
      create_list :message, 3, messager: users[0], messagee: users[1] 
    }
    let!(:messages_from1to0) { 
      create_list :message, 3, messager: users[1], messagee: users[0] 
    }

    context "Logged in as users[0]" do

      before { get '/messages', headers: jwt_headers_for(users[0]) }

      it { expect(response.status).to eq 200 }
      it { expect(response_json.length).to eq 3 }

      it "returns all of users[0]'s received_messages" do
        # Remember! #as_json returns symbol-keys; any Rails controller's JSON
        # response is always fully stringified. If we're going to deep-equals
        # compare, we'll need to deep-stringify #as_json's keys first.
        expect(response_json)
          .to eq users[0].received_messages.as_json.map(&:deep_stringify_keys!)
      end
    end

    context "Logged in as users[1]" do

      before { get '/messages', headers: jwt_headers_for(users[1]) }

      it { expect(response.status).to eq 200 }
      it { expect(response_json.length).to eq 3 }

      it "returns all of users[1]'s received_messages" do
        # Remember! #as_json returns symbol-keys; any Rails controller's JSON
        # response is always fully stringified. If we're going to deep-equals
        # compare, we'll need to deep-stringify #as_json's keys first.
        expect(response_json)
          .to eq users[1].received_messages.as_json.map(&:deep_stringify_keys!)
      end
    end

    context "Not logged in" do
      before { get '/messages', headers: { 'Logged-In-?': 'Nah' } }
      it { expect(response.status).to eq 401 }
    end
  end

  describe "Creating a new message" do

    let!(:messager) { create :user }
    let!(:messagee) { create :user }
    
    context "Logged in" do

      before do
        post '/messages', 
          headers: jwt_headers_for(messager), 
          params: { message: message_attrs }.to_json
      end

      context "Happy params" do

        let!(:message_attrs) do
          attributes_for :message, messagee_id: messagee.id
        end

        it { expect(response.status).to eq 200 }
        it "creates and returns a new Message object with messager=current_user" do
          expect(response_json['data']['relationships']['messager']['data']['id'])
            .to eq messager.id
        end

        it "creates and returns a new Message object with messagee=params[messagee]" do
          expect(response_json['data']['relationships']['messagee']['data']['id'])
            .to eq messagee.id
        end
      end

      context "Sad params" do

        context "Content is missing" do

          let!(:message_attrs) do
            attributes_for(:message, messagee_id: messagee.id).except!(:content)
          end

          it { expect(response.status).to eq 422 }
          it "returns an error message complaining about the lack of content" do
            expect(response_json['errors']).to eq({ "content" => ["can't be blank"] })
          end
        end

        context "Messagee ID is missing" do

          let!(:message_attrs) do
            attributes_for(:message).except!(:messagee_id)
          end

          it { expect(response.status).to eq 422 }
          it "returns an error message complaining about the missing messagee ID" do
            expect(response_json['errors']).to eq({ "messagee" => ["must exist"] })
          end
        end
      end
    end

    context "Not logged in" do
      before { post '/messages', headers: { 'Logged-In-?': 'Nah' } }
      it { expect(response.status).to eq 401 }
    end
  end



  # Most common use case: populating Message#seen_at: defaults to nil, but becomes a # timestamp when viewed from the client. 
  describe "Updating an existing message" do

    let(:messager) { create :user }
    let(:messagee) { create :user }
    let(:message) { create :message, messager: messager, messagee: messagee }
    let(:seen_at_timestamp) { 
      Faker::Time.between(from: Time.now - 1.week, to: Time.now + 1.week).to_s 
    }

    context "Logged in" do
      context "current_user is messager" do

        before {
          put "/messages/#{message.id}", 
            headers: jwt_headers_for(messager),
            params: { seen_at: seen_at_timestamp }.to_json
          message.reload
        }

        it { expect(response.status).to eq 200 }
        it "returns the message JSON" do
          expect(response_json['data'])
            .to eq message.as_json.deep_stringify_keys!['data']
        end
      end

      context "current_user is messagee" do

        before {
          put "/messages/#{message.id}", 
            headers: jwt_headers_for(messagee),
            params: { seen_at: seen_at_timestamp }.to_json
          message.reload
        }

        it { expect(response.status).to eq 200 }
        it "returns the message JSON" do
          expect(response_json['data'])
            .to eq message.as_json.deep_stringify_keys!['data']
        end
      end

      context "current_user is totally unrelated user" do

        let(:totally_unrelated_user) { create :user }

        before {
          put "/messages/#{message.id}", 
            headers: jwt_headers_for(totally_unrelated_user),
            params: { seen_at: seen_at_timestamp }.to_json
        }

        it { expect(response.status).to eq 403 }
      end
    end

    context "Not logged in at all" do
      before { put "/messages/#{message.id}", headers: { 'Logged-In-?': 'Nah' } }
      it { expect(response.status).to eq 401 }
    end
  end

  describe "Deleting a message" do

    let(:messager) { create :user }
    let(:messagee) { create :user }
    let(:message) { create :message, messager: messager, messagee: messagee }

    context "Logged in" do
      context "current_user is messager" do

        before {
          delete "/messages/#{message.id}", 
            headers: jwt_headers_for(messager)
        }

        it { expect(response.status).to eq 200 }
        it "returns the message JSON" do
          expect(response_json['data'])
            .to eq message.as_json.deep_stringify_keys!['data']
        end
      end

      context "current_user is messagee" do

        before {
          delete "/messages/#{message.id}", 
            headers: jwt_headers_for(messagee)
        }

        it { expect(response.status).to eq 200 }
        it "returns the message JSON" do
          expect(response_json['data'])
            .to eq message.as_json.deep_stringify_keys!['data']
        end
      end

      context "current_user is totally unrelated user" do

        let(:totally_unrelated_user) { create :user }

        before {
          delete "/messages/#{message.id}", 
            headers: jwt_headers_for(totally_unrelated_user)
        }

        it { expect(response.status).to eq 403 }
      end
    end

    context "Not logged in at all" do
      before { delete "/messages/#{message.id}", headers: { 'Logged-In-?': 'Nah' } }
      it { expect(response.status).to eq 401 }
    end
  end
end