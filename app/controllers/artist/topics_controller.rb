class Artist::TopicsController < ApplicationController
  # トピックス新規投稿画面
  def new
    @topic =Topic.new
  end

  # トピックス新規作成アクション
  def create
    @topic = current_artist_user.topics.new(topic_params)

    # 受け取ったタグの値をスペースで区切り配列にし保存する(半角と全角の両方を対応させる)
    @tag_list = params[:topic][:name].split(/[ |　]/)
    if @topic.save
      @topic.save_tag(@tag_list)
      redirect_to artist_topic_path(@topic)
    else
      render :new
    end
  end

  # トピックス一覧画面
  def index
    @artist_user = current_artist_user
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

  # トピックス編集画面
  def edit
    @topic = Topic.find(params[:id])
    @tag_list = @topic.tags.pluck(:name).join('　')
  end

  # トピックス情報更新
  def update
    topic = Topic.find(params[:id])
    tag_list = params[:topic][:name].split(/[ |　]/)

    if topic.update(topic_params)
      topic.save_tag(tag_list)
      redirect_to artist_topic_path(topic)
    else
      @topic = Topic.find(params[:id])
      render :edit
    end
  end

  # トピックス情報削除(詳細画面からの削除ボタンクリック時)
  def destroy
    topic = Topic.find(params[:id])
    topic.destroy
    redirect_to artist_topics_path
  end

  # トピックス情報削除(トピックス一覧画面からの削除ボタンクリック時)
  def from_index_destroy
    topic = Topic.find(params[:id])
    topic.destroy
    redirect_to request.referer
  end

  # トピックス検索アクション
  def search
    @artist_user = current_artist_user
    @tag_lists = Tag.active_tags
    @topics = Topic.active_topics.search(params[:keyword]).order(created_at: :desc).page(params[:page]).per(10)
    @keyword = params[:keyword]
    render "index"
  end

  # タグ検索アクション
  def tag_search
    @artist_user = current_artist_user
    @tag_lists = Tag.active_tags
    @tag = Tag.find(params[:tag_id])
    @topics = @tag.topics.active_topics.order(created_at: :desc).page(params[:page]).per(10)
    @search_display = @tag.name
    render "index"
  end

  private
  # ストロングパラメータ
  def topic_params
    params.require(:topic).permit(:artist_user_id, :body, :topic_image, :youtube_url)
  end
end
