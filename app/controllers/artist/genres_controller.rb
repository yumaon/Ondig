class Artist::GenresController < ApplicationController
  def index
    @artist_user = current_artist_user
    @genre = Genre.new
    @genres = Genre.all
  end

  def create
    @genre = Genre.new(genre_params)
    @genre.save
    redirect_to artist_genres_path
  end
  
  def update
    @artist_user = current_artist_user
    @artist_user.update(artist_user_params)
    redirect_to artist_artist_users_my_page_path
  end

  private

  def genre_params
    params.require(:genre).permit(:name)
  end
  
  def artist_user_params
    params.require(:artist_user).permit(:genre_id)
  end

end
