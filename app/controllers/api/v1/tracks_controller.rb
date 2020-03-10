class Api::V1::TracksController < ApplicationController
  def index
    response = RSpotify.authenticate(Rails.application.credentials.spotify[:client_id], Rails.application.credentials.spotify[:client_secret])
    tracks = RSpotify::Track.search(params[:q])
    sanitized_tracks = []
    
    tracks.each do |tracks|
      sanitized_tracks.push(
        {
                  name: tracks.name,
                  spotify_id: tracks.id,
                }
      )
    end
    render json: { tracks: sanitized_tracks }
  end
end
