class Public::ProfileTopicsController < ApplicationController
  def index
    @artist_user = ArtistUser.find(params[:artist_user_id])
    @topics = @artist_user.topics.order(created_at: :desc)

    if public_user_signed_in?
      @current_PublicUser_join = Join.where(public_user_id: current_public_user.id)
      @ArtistUser_join = Join.where(artist_user_id: @artist_user.id)

      @current_PublicUser_join.each do |current_public|
        @ArtistUser_join.each do |other_artist|
          if current_public.room_id == other_artist.room_id then
            @isRoom = true
            @roomId = current_public.room_id
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
end
