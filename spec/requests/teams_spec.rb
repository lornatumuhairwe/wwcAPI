require 'rails_helper'

RSpec.describe 'Teams API', type: :request do
  let!(:teams) { create_list(:team, 10) }
  let(:team_id) { teams.first.id }
  describe 'GET /teams' do
    before { get '/teams' }

    it 'returns teams' do
      expect(json).not_to be_empty
      expect(json.size).to eq 10
    end

    it 'returns response status 200' do
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'POST /teams' do
    let(:valid_attributes) { { team: { name: 'U.S.A' } } }
    let(:invalid_attributes) { { team: { name: '' }}}

    context 'with valid attributes' do
      before { post '/teams', params: valid_attributes }
      it 'creates a new team' do
        expect(json['name']).to eq('U.S.A')
      end

      it 'returns status code of 201' do
        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid attributes' do
      before { post '/teams', params: invalid_attributes }
      it 'returns a 422 status code' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(json['error']).to match(/Validation failed: Name can't be blank/)
      end
    end
  end

  describe 'GET /teams/:id' do
    before { get "/teams/#{team_id}" }

    context 'with existing team' do
      it 'returns 200 status code' do
        expect(response).to have_http_status(200)
      end

      it 'returns team' do
        expect(json['id']).to eq(team_id)
      end
    end

    context 'with non existing team' do
      let(:team_id) { 0 }

      it 'returns 404 status code' do
        expect(response).to have_http_status(404)
      end

      it 'returns not found error message' do
        expect(response.body).to match(/Couldn't find Team/)
      end
    end
  end

  describe 'PUT /teams/:id' do
    before { put "/teams/#{team_id}", params: { team: { name: 'USNWT' }}}
    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end

    it 'updates the record' do
      expect(json['name']).to eq('USNWT')
    end
  end

  describe 'DELETE /teams/:id' do
    before { delete "/teams/#{team_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
