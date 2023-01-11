class Artist::TopicsController < ApplicationController
  def new
    @topic =Topic.new
  end

  def create
    topic = current_artist_user.topics.new(topic_params)

    # 受け取ったタグの値をスペースで区切り配列にし保存する(半角と全角の両方を対応させる)
    tag_list = params[:topic][:name].split(/[ |　]/)
    if topic.save
      topic.save_tag(tag_list)
      redirect_to artist_topic_path(topic)
    else
     render :new
    end
  end

  def index
    @topics = Topic.all
    @tag_lists = Tag.all
  end

  def show
    @topic = Topic.find(params[:id])
    @topic_comment = TopicComment.new
  end

  def edit
    @topic = Topic.find(params[:id])
    @tag_list = @topic.tags.pluck(:name).join('　')
  end

  def update
    topic = Topic.find(params[:id])
    tag_list = params[:topic][:name].split(/[ |　]/)

    if topic.update(topic_params)
      topic.save_tag(tag_list)
      redirect_to artist_topic_path(topic)
    else
      render :edit
    end
  end

  def destroy
    topic = Topic.find(params[:id])
    topic.destroy
    redirect_to artist_topics_path
  end

  def tag_search
    @tag_lists = Tag.all
    @tag = Tag.find(params[:tag_id])
    @topics = @tag.topics.all
    @search_display = @tag.name
    @search_display_text = "の関連Topics"
    render "index"
  end

  private

  def topic_params
    params.require(:topic).permit(:artist_user_id, :body, :topic_image, :youtube_url)
  end
end
