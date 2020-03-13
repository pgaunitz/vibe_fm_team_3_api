require  'coveralls'
Coveralls.wear_merged!('rails')
require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require 'webmock/rspec'
WebMock.enable!
# WebMock.allow_net_connect!
# WebMock.disable!
include WebMock::API

WebMock::API


stub_request(:post, "https://accounts.spotify.com/api/token").
with(
  body: {"grant_type"=>"client_credentials"},
  headers: {
  'Accept'=>'*/*'
  }).
to_return(status: 200, body: "{\"access_token\":\"ttttt\"}", headers: {})

require File.expand_path('../config/environment', __dir__)

abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'rspec/rails'
require 'spec_helper'


ActiveRecord::Migration.maintain_test_schema!

Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!
  config.include FactoryBot::Syntax::Methods
  config.include(Shoulda::Matchers::ActiveRecord, type: :model)
  config.include ResponseJSON
  config.before do
    stub_request(:get, "https://api.spotify.com/v1/search?limit=20&offset=0&q=Vertigo&type=track").
    with(
      headers: {
      'Accept'=>'*/*'
      }).
    to_return(status: 200, body: file_fixture('spotify_vertigo_tracks_response.json'), headers: {})


    stub_request(:get, "https://api.spotify.com/v1/search?limit=20&offset=0&q=asdlfjal%3Bksdfjkl%3Basdjfkl%3Basjdflk%3Bajsdl%3Bfads&type=track").
      with(
        headers: {
      'Accept'=>'*/*'
        }).
      to_return(status: 200, body: file_fixture('spotify_no_results_for_query.json'), headers: {})

    stub_request(:get, "https://api.spotify.com/v1/search?limit=20&offset=0&q=U2&type=artist").
      with(
        headers: {
      'Accept'=>'*/*',
        }).
      to_return(status: 200, body: file_fixture('spotify_U2_artists_response.json'), headers: {})
    stub_request(:get, "https://api.spotify.com/v1/search?limit=20&offset=0&q=asdlfjal%3Bksdfjkl%3Basdjfkl%3Basjdflk%3Bajsdl%3Bfads&type=artist").
      with(
        headers: {
        'Accept'=>'*/*',
        }).
      to_return(status: 200, body: file_fixture('spotify_no_results_for_artist_query.json'), headers: {})
  end
end



