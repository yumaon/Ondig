class Artist::ArtistUsersController < ApplicationController
  def index
    @artist_users = ArtistUser.all
  end

  def show
    @artist_user = current_artist_user
    # TimeLineを表示するため、自身のtopicsとfollowしているユーザーのtopicsを取得
    @tl_topics = Topic.where(artist_user_id: [current_artist_user.id, *current_artist_user.artist_following_ids])
  end

  # My pageで自身が投稿したtopic一覧を表示するためのアクション
  def my_topics
    @artist_user = current_artist_user
    @topics = @artist_user.topics
  end

  # My page の My Topicsページで削除ボタンを実行したとき用のアクション
  def destroy
    topic = Topic.find(params[:id])
    topic.destroy
    redirect_to my_page_my_topics_artist_artist_users_path
  end

  def edit
    @artist_user = current_artist_user
  end

  def update
    @artist_user = current_artist_user
    @artist_user.update(artist_user_params)
    redirect_to my_page_artist_artist_users_path
  end

  def unsubscribe
  end

  private

  def artist_user_params
    params.require(:artist_user).permit(:profile_image, :artist_name, :rep_name, :rep_name_kana, :activity_location, :email, :genre_id)
  end
end
