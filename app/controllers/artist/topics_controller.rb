class Artist::TopicsController < ApplicationController
  def new
    @topic =Topic.new
  end

  def create
    topic = current_artist_user.topics.new(topic_params)
    topic.save
    redirect_to artist_topics_path
  end

  def index
    @topics = Topic.all
  end

  def show
  end

  def edit
  end

  private

  def topic_params
    params.require(:topic).permit(:artist_user_id, :body, :topic_image, :youtube_url)
  end
end
