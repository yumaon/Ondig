class Artist::PublicUsersController < ApplicationController
  def show
    @public_user = PublicUser.find(params[:id])

    @current_ArtistUser_join = Join.where(artist_user_id: current_artist_user.id)
    @PublicUser_join = Join.where(public_user_id: @public_user.id)

    @current_ArtistUser_join.each do |current_artist|
      @PublicUser_join.each do |other_public|
        if current_artist.room_id == other_public.room_id then
          @isRoom = true
          @roomId = current_artist.room_id
        end
      end
      if @isRoom
      else
        @room = Room.new
        @join = Join.new
      end
    end
  end
end
