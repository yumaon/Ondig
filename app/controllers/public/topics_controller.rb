class Public::TopicsController < ApplicationController
  # トピックス一覧画面
  def index
    @public_user = current_public_user
    # 退会していないユーザーのトピックスを取得
    @topics = Topic.active_topics.order(created_at: :desc).page(params[:page]).per(10)
    # 退会していないユーザーのトピックスに紐づくすべてのタグを取得
    @tag_lists = Tag.active_tags
  end

  # トピックス詳細画面
  def show
    @topic = Topic.find(params[:id])
    # トピックスに紐づいているコメントを取得（退会していないユーザーのみ）
    @topic_comments = @topic.topic_comments.active_comments.order(created_at: :desc).page(params[:page]).per(6)
    @topic_comment = TopicComment.new
    # コメント数
    @topic_comments_count = @topic_comments.total_count
  end

  # トピックス検索アクション
  def search
    @public_user = current_public_user
    @tag_lists = Tag.active_tags
    @topics = Topic.active_topics.search(params[:keyword]).order(created_at: :desc).page(params[:page]).per(10)
    @keyword = params[:keyword]
    render "index"
  end

  # タグ検索アクション
  def tag_search
    @public_user = current_public_user
    @tag_lists = Tag.active_tags
    @tag = Tag.find(params[:tag_id])
    @topics = @tag.topics.active_topics.order(created_at: :desc).page(params[:page]).per(10)
    @search_display = @tag.name
    render "index"
  end
end
