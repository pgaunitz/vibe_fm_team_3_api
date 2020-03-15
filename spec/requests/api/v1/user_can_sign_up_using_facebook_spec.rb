RSpec.describe 'POST /api/v1/auth', type: :request do
    describe 'successfully' do
        before do
            post '/api/v1/auth',
            params {
            uid: '1234567890',
            email: 'user@mail.com',
            provider: 'facebook'
            }
        end

        it 'returns auth token' do
            expect(response_jason).to include 'auth_token'
        end

        it 'returns expiry' do
            expect(response_jason).to include 'expiry'
        end

        it 'returns client_id' do
            expect(response_jason).to include 'client_id'
        end

        it 'returns uid' do
            expect(response_jason['uid']).to eq '1234567890'
        end

        it 'returns 200 status' do
            expect(response_jason).to eq 200
        end
    end
end