class Admin::TopicsController < ApplicationController
  # Topics一覧
  def index
    # Artistを指定してindexページを表示させる場合
    if params[:artist_id].present?
      @artist_user = ArtistUser.find(params[:artist_id])
      @topics = ArtistUser.find(params[:artist_id]).topics.order(created_at: :desc)
      @tag_lists = Tag.all

    # Artistは指定せず、indexページを表示させる場合
    else
      @topics = Topic.all.order(created_at: :desc)
      @tag_lists = Tag.all
    end
  end

  # トピックス詳細画面を表示
  def show
    @topic = Topic.find(params[:id])
  end

  # トピックスを削除するアクション
  def destroy
    topic = Topic.find(params[:id])
    topic.destroy
    redirect_to admin_topics_path
  end

  # キーワード検索アクション
  def search
    @tag_lists = Tag.all
    @topics = Topic.search(params[:keyword])
    @keyword = params[:keyword]
    render "index"
  end

  # タグ検索アクション
  def tag_search
    @tag_lists = Tag.all
    @tag = Tag.find(params[:tag_id])
    @topics = @tag.topics.all
    @search_display = @tag.name
    render "index"
  end
end
