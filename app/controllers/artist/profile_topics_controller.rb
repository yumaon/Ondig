class Artist::ProfileTopicsController < ApplicationController
  def index
    @artist_user = ArtistUser.find(params[:artist_user_id])
    @topics = @artist_user.topics.order(created_at: :desc).page(params[:page]).per(10)
    @tag_lists = Tag.all

    @current_ArtistUser_join = Join.where(artist_user_id: current_artist_user.id)
    @ArtistUser_join = Join.where(artist_user_id: @artist_user.id)
    unless @artist_user.id == current_artist_user.id
      @current_ArtistUser_join.each do |current_artist|
        @ArtistUser_join.each do |other_artist|
          if current_artist.room_id == other_artist.room_id then
            @isRoom = true
            @roomId = current_artist.room_id
          end
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
