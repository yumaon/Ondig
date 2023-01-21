class Artist::ProfilesController < ApplicationController
  def show
    @artist_user = ArtistUser.find(params[:id])
    @topic = Topic.order(created_at: :desc).find_by(artist_user_id: @artist_user.id)

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

  def edit
    @artist_user = ArtistUser.find(params[:id])
  end

  def update
    @artist_user = ArtistUser.find(params[:id])
    @artist_user.update(profile_params)
    redirect_to profile_artist_artist_user_path(@artist_user)
  end

  private

  def profile_params
    params.require(:artist_user).permit(:header_image, :youtube_url, :introduction)
  end
end
