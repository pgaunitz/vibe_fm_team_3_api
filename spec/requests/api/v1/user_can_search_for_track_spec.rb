RSpec.describe 'GET /api/v1/tracks', type: :request do
    before do
        get '/api/v1/tracks',
        params: {
            q: 'Vertigo' 
        }
    end
    it 'returns a 200 response status' do
        expect(response.status).to eq 200
    end

    it 'returns Vertigo song' do
        expect(JSON.parse(response.body)['tracks'].first['name']).to eq 'Vertigo'
    end

    describe 'an invalid search' do
        before do
          get '/api/v1/tracks',
          params: {
              q: ''
          }
        end

        it 'returns a 400 response status' do
            expect(response.status).to eq 400
          end
    end
end 