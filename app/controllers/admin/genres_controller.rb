class Admin::GenresController < ApplicationController
  # ジャンル一覧・ジャンル新規作成フォーム用アクション
  def index
    # 設定者数が０のGenreを一覧表示させる場合。(フォームからgenre_artist_nilの値を受け取った場合)
    if params[:genre_artist_nil].present?
      artist_user = ArtistUser.all
      true_artist_genres = []
      # 全ArtistUserのgenre_idを取得し、true_artist_genresに格納する。
      artist_user.each do |artist|
        true_artist_genres << artist.genre_id
      end
      # 上記ので格納したgenre_idは設定者が存在するので、それ以外(設定者無し)のGerneを検索し取得
      @genres = Genre.where.not(id: true_artist_genres)
      @genre_nil_artist_users = ArtistUser.where(genre_id: nil).all

    # 全てのGenreを表示させる場合
    else
      @genre = Genre.new
      @genres = Genre.all
      @genre_nil_artist_users = ArtistUser.where(genre_id: nil).all
    end
  end

  # ジャンル新規作成アクション
  def create
    @genre = Genre.new(genre_params)
    @genre.save
    redirect_to admin_genres_path
  end

  # ジャンル名編集画面
  def edit
    @genre = Genre.find(params[:id])
  end

  # ジャンル情報更新
  def update
    @genre = Genre.find(params[:id])
    @genre.update(genre_params)
    redirect_to admin_genres_path
  end

  # ジャンル情報の削除
  def destroy
    genre = Genre.find(params[:id])
    # ジャンル削除の際、削除対象のジャンルを登録しているArtistUserを取り出し、そのArtistUserのgenre_idをnilにする。
    # （genre.rbのアソシエーションでdependent: :destroyを設定していないため）
    if genre.destroy
      genre.artist_users.each do |artist_user|
        artist_user.genre_id = nil
        artist_user.save
      end
    end
    redirect_to admin_genres_path
  end

  private

  def genre_params
    params.require(:genre).permit(:name)
  end
end
