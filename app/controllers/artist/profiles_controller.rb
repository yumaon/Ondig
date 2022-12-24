class Artist::ProfilesController < ApplicationController
  def show
    @artist_user = ArtistUser.find(params[:id])
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
    params.require(:artist_user).permit(:header_image, :youtube_url)
  end
end
