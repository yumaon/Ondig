class Public::TopicsController < ApplicationController
  def index
    @topics = Topic.all
    @tag_lists = Tag.all
  end

  def show
    @topic = Topic.find(params[:id])
    @topic_comment = TopicComment.new
  end

  def tag_search
    @tag_lists = Tag.all
    @tag = Tag.find(params[:tag_id])
    @topics = @tag.topics.all
    @search_display = @tag.name
    @search_display_text = "の関連Topics"
    render "index"
  end
end
