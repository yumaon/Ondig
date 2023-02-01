class Artist::GenresController < ApplicationController
  # ジャンル一覧・新規作成画面
  def index
    @artist_user = current_artist_user
    @genre = Genre.new
    @genres = Genre.all
  end

  # ジャンル新規作成
  def create
    @genre = Genre.new(genre_params)
    # ジャンルを新規作成する際に、アーティストのジャンルを新規作成したジャンルに変更させる。
    if @genre.save
      current_artist_user.genre_id = @genre.id
      current_artist_user.save
      flash[:notice] = "ジャンルを新規作成し、登録しました。"
      redirect_to my_page_artist_artist_users_path
    else
      @artist_user = current_artist_user
      @genres = Genre.all
      render :index
    end
  end

  private
  # ストロングパラメータ
  def genre_params
    params.require(:genre).permit(:name)
  end
end
