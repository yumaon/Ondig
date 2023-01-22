class Artist::ArtistUsersController < ApplicationController
  # Artist一覧画面
  def index
    @genres = Genre.all
    @artist_user = current_artist_user
    @search_params = artist_user_search_params

    # サイドバーのジャンル検索ボタンを押された時の処理
    if params[:name].present?
      # 指定されたジャンルに紐づいている、退会していないArtistUserを取得
      @artist_users = Genre.find(params[:name]).artist_users.active
    else
      # 退会していないArtistUserを取得
      @artist_users = ArtistUser.active
    end
  end

  # Artist検索アクション
  def search
    @artist_user = current_artist_user
    @genres = Genre.all
    @search_params = artist_user_search_params
    @artist_users = ArtistUser.active.search(@search_params).includes(:genre)
    render "index"
  end

  # My page
  def show
    @artist_user = current_artist_user
    # TimeLineを表示するため、自身のtopicsとfollowしている退会していないユーザーのtopicsを取得
    @topics = Topic.active_topics.where(artist_user_id: [current_artist_user.id, *current_artist_user.artist_following_ids]).order(created_at: :desc)
  end

  # My pageで自身が投稿したtopic一覧を表示するためのアクション
  def my_topics
    @artist_user = current_artist_user
    @topics = @artist_user.topics.order(created_at: :desc)
  end

  # 登録情報編集画面
  def edit
    @artist_user = current_artist_user
  end

  # 登録情報更新
  def update
    @artist_user = current_artist_user
    @artist_user.update(artist_user_params)
    redirect_to my_page_artist_artist_users_path
  end

  # 退会確認画面
  def unsubscribe
    @artist_user = current_artist_user
  end

  # 退会処理(論理削除)
  def hide
    @artist_user = current_artist_user
    @artist_user.update(is_deleted: true)
    reset_session
    redirect_to root_path
  end

  private

  def artist_user_params
    params.require(:artist_user).permit(:profile_image, :artist_name, :rep_name, :rep_name_kana, :activity_location, :email, :genre_id)
  end

  def artist_user_search_params
    params.fetch(:search, {}).permit(:artist_name, :genre_id, :activity_location)
  end
end
