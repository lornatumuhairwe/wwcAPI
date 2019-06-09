require 'rails_helper'

RSpec.describe 'Players API' do
  let(:team) { create :team }
  let(:team_id) { team.id }
  let!(:players) { create_list :player, 15, team: team }
  let(:player_id) { players.first.id }
  let(:user) { create :user }
  let(:valid_headers) { { "Authorization": "Token token=#{user.api_key}"} }

  context 'with authorized requests' do
    describe 'GET /teams/:team_id/players' do
      before { get "/teams/#{team_id}/players", headers: valid_headers }

      context 'with existing team' do
        it 'returns status code 200' do
          expect(response).to have_http_status(200)
        end

        it 'returns players' do
          expect(json.size).to eq(15)
        end
      end

      context 'with non existing team' do
        let(:team_id) { 100 }

        it 'returns status code 404' do
          expect(response).to have_http_status(404)
        end

        it 'returns error message' do
          expect(json['error']).to match(/Couldn't find Team/)
        end
      end
    end

    describe 'GET /teams/:team_id/players/:id' do
      before { get "/teams/#{team_id}/players/#{player_id}", headers: valid_headers }

      context 'when player exists' do
        it 'returns 200 status code' do
          expect(response).to have_http_status(200)
        end

        it 'returns player' do
          expect(json['id']).to eq(player_id)
        end
      end

      context "when player doesn't exist" do
        let(:player_id) { 0 }

        it 'returns 404 status code' do
          expect(response).to have_http_status(404)
        end

        it 'returns error message' do
          expect(json['error']).to match(/Couldn't find Player/)
        end
      end
    end

    describe 'POST /teams/:team_id/players' do
      let(:valid_attributes) { { name: 'Alex Morgan', position: 'Forward' } }
      let(:invalid_attributes) { { position: 'Forward' } }

      context 'with valid attributes' do
        before { post "/teams/#{team_id}/players", params: valid_attributes, headers: valid_headers }

        it 'creates new player' do
          expect(json['name']).to eq('Alex Morgan')
        end

        it 'returns http status code 201' do
          expect(response).to have_http_status(201)
        end
      end

      context 'with invalid attributes' do
        before { post "/teams/#{team_id}/players", params: invalid_attributes, headers: valid_headers }

        it 'returns http status code 422' do
          expect(response).to have_http_status(422)
        end

        it 'returns error message' do
          expect(json['error']).to match(/Validation failed: Name can't be blank/)
        end
      end
    end

    describe 'PUT /teams/:team_id/players/:id' do
      before { put "/teams/#{team_id}/players/#{player_id}", params: { name: 'Rapinoe' }, headers: valid_headers }

      it 'returns http status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'updates player' do
        expect(json['name']).to eq('Rapinoe')
      end
    end

    describe 'DELETE /team/:team_id/players/:id' do
      before { delete "/teams/#{team_id}/players/#{player_id}", headers: valid_headers }

      it 'returns http status code 204' do
        expect(response).to have_http_status(:no_content)
      end
    end
  end

  context 'with unauthorized request' do
    describe 'GET /teams/:team_id/players' do
      before { get "/teams/#{team_id}/players" }

      context 'with existing team' do
        it 'returns response status 401' do
          expect(response).to have_http_status(:unauthorized)
        end

        it 'returns unauthorized error message' do
          expect(response.body).to match(/HTTP Token: Access denied/)
        end
      end

      context 'with non existing team' do
        let(:team_id) { 100 }

        it 'returns response status 401' do
          expect(response).to have_http_status(:unauthorized)
        end

        it 'returns unauthorized error message' do
          expect(response.body).to match(/HTTP Token: Access denied/)
        end
      end
    end

    describe 'GET /teams/:team_id/players/:id' do
      before { get "/teams/#{team_id}/players/#{player_id}" }

      context 'when player exists' do
        it 'returns response status 401' do
          expect(response).to have_http_status(:unauthorized)
        end

        it 'returns unauthorized error message' do
          expect(response.body).to match(/HTTP Token: Access denied/)
        end
      end

      context "when player doesn't exist" do
        let(:player_id) { 0 }

        it 'returns response status 401' do
          expect(response).to have_http_status(:unauthorized)
        end

        it 'returns unauthorized error message' do
          expect(response.body).to match(/HTTP Token: Access denied/)
        end
      end
    end

    describe 'POST /teams/:team_id/players' do
      let(:valid_attributes) { { name: 'Alex Morgan', position: 'Forward' } }
      let(:invalid_attributes) { { position: 'Forward' } }

      context 'with valid attributes' do
        before { post "/teams/#{team_id}/players", params: valid_attributes }

        it 'returns response status 401' do
          expect(response).to have_http_status(:unauthorized)
        end

        it 'returns unauthorized error message' do
          expect(response.body).to match(/HTTP Token: Access denied/)
        end
      end

      context 'with invalid attributes' do
        before { post "/teams/#{team_id}/players", params: invalid_attributes }

        it 'returns response status 401' do
          expect(response).to have_http_status(:unauthorized)
        end

        it 'returns unauthorized error message' do
          expect(response.body).to match(/HTTP Token: Access denied/)
        end
      end
    end

    describe 'PUT /teams/:team_id/players/:id' do
      before { put "/teams/#{team_id}/players/#{player_id}", params: { name: 'Rapinoe' } }

      it 'returns response status 401' do
        expect(response).to have_http_status(:unauthorized)
      end

      it 'returns unauthorized error message' do
        expect(response.body).to match(/HTTP Token: Access denied/)
      end
    end

    describe 'DELETE /team/:team_id/players/:id' do
      before { delete "/teams/#{team_id}/players/#{player_id}" }

      it 'returns response status 401' do
        expect(response).to have_http_status(:unauthorized)
      end

      it 'returns unauthorized error message' do
        expect(response.body).to match(/HTTP Token: Access denied/)
      end
    end
  end
end
