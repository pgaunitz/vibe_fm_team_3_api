class Api::V1::ArtistsController < ApplicationController
    before_action :check_query_param
  
    def index
        artists = RSpotify::Artist.search(params[:q])
  
      sanitized_artists = []
      if artists.empty?
        render json: { error_message: "There is no matches for the artist you are trying to search" }, status: 400
      else
      artists.each do |artist|
        binding.pry
        sanitized_artists.push(
          {
            name: artist.name,
            genre: artist.genres,
            spotify_id: artist.id
          }
        )
      end
      render json: { artists: sanitized_artists }
    end
   end
  
   private
  
   def check_query_param
    if params[:q].blank?
      render json: {error_message: 'No query'}, status: 400
      return
    end
   end
  end