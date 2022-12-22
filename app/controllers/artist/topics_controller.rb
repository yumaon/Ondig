class Artist::TopicsController < ApplicationController
  def new
    @topic =Topic.new
  end

  def create
    topic = current_artist_user.topics.new(topic_params)
    topic.save
    redirect_to artist_topic_path(topic)
  end

  def index
    @topics = Topic.all
  end

  def show
    @topic = Topic.find(params[:id])
  end

  def edit
    @topic = Topic.find(params[:id])
  end

  def update
    topic = Topic.find(params[:id])
    topic.update(topic_params)
    redirect_to artist_topic_path(topic)
  end

  def destroy
    topic = Topic.find(params[:id])
    topic.destroy
    redirect_to artist_topics_path
  end

  private

  def topic_params
    params.require(:topic).permit(:artist_user_id, :body, :topic_image, :youtube_url)
  end
end
