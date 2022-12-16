class Artist::ArtistUsersController < ApplicationController
  def show
    @artist_user = current_artist_user
  end

  def edit
    @artist_user = current_artist_user
  end

  def update
    @artist_user = current_artist_user
    @artist_user.update(artist_user_params)
    redirect_to artist_artist_users_my_page_path
  end

  def unsubscribe
  end

  private

  def artist_user_params
    params.require(:artist_user).permit(:profile_image, :artist_name, :rep_name, :rep_name_kana, :activity_location, :email)
  end
end
