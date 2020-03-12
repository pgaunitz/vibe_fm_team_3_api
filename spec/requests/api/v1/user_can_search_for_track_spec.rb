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
        expect(response_json['tracks'].first['name']).to eq 'Vertigo'
    end

    it 'returns also the artist of the song' do
        expect(response_json['tracks'][0]['artist']).to eq 'Khalid'
    end

    describe 'an invalid search with empty string' do
        before do
          get '/api/v1/tracks',
          params: {
              q: ' '
          }
        end

        it 'returns a 400 response status' do
            expect(response.status).to eq 400
        end

        it 'returns a error message' do
            expect(response_json['error_message']).to eq "No query"
        end
    end
    describe 'an invalid search with no matching text' do
        before do
          get '/api/v1/tracks',
          params: {
              q: 'asdlfjal;ksdfjkl;asdjfkl;asjdflk;ajsdl;fads'
          }
        end

        it 'returns a 400 response status' do
            expect(response.status).to eq 400
        end

        it 'returns a error message' do
            expect(response_json['error_message']).to eq "There is no matches for the song you are trying to search"
        end
    end
end 