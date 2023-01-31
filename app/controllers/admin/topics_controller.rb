class Admin::TopicsController < ApplicationController
  before_action :authenticate_admin!
  # Topics一覧
  def index
    # Artistを指定してトピックス一覧ページを表示させる場合
    if params[:artist_id].present?
      @artist_user = ArtistUser.find(params[:artist_id])
      @topics = ArtistUser.find(params[:artist_id]).topics.order(created_at: :desc).page(params[:page]).per(10)
      @tag_lists = Tag.all

    # Artistは指定せず、トピックス一覧ページを表示させる場合
    else
      @topics = Topic.all.order(created_at: :desc).page(params[:page]).per(10)
      @tag_lists = Tag.all
    end
  end

  # トピックス詳細画面を表示
  def show
    @topic = Topic.find(params[:id])
    @topic_comments = @topic.topic_comments.order(created_at: :desc).page(params[:page]).per(6)
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
    @topics = Topic.search(params[:keyword]).order(created_at: :desc).page(params[:page]).per(10)
    @keyword = params[:keyword]
    render "index"
  end

  # タグ検索アクション
  def tag_search
    @tag_lists = Tag.all
    @tag = Tag.find(params[:tag_id])
    @topics = @tag.topics.all.order(created_at: :desc).page(params[:page]).per(10)
    @search_display = @tag.name
    render "index"
  end
end
