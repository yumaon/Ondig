class Public::TopicsController < ApplicationController
  def index
    @topics = Topic.all
  end

  def show
    @topic = Topic.find(params[:id])
    @topic_comment = TopicComment.new
  end
end
