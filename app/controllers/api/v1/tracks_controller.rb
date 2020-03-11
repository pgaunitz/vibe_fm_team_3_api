class Api::V1::TracksController < ApplicationController
  def index
    tracks = RSpotify::Track.search(params[:q])

    sanitized_tracks = []
    if tracks.empty?
      render json: { song_not_found: "There is no matches for the song you are trying to search" }, status: 400
    else
    tracks.each do |track|
      sanitized_tracks.push(
        {
            name: track.name,
            artist: track.artists.first.name,
            spotify_id: track.id
        }
      )
    end
    render json: { tracks: sanitized_tracks }
  end
 end
end

