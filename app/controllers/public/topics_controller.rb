class Public::TopicsController < ApplicationController
  def index
    @public_user = current_public_user
    @topics = Topic.all
    @tag_lists = Tag.all
  end

  def show
    @topic = Topic.find(params[:id])
    @topic_comment = TopicComment.new
  end

  def search
    @public_user = current_public_user
    @tag_lists = Tag.all
    @topics = Topic.search(params[:keyword])
    @keyword = params[:keyword]
    render "index"
  end

  def tag_search
    @public_user = current_public_user
    @tag_lists = Tag.all
    @tag = Tag.find(params[:tag_id])
    @topics = @tag.topics.all
    @search_display = @tag.name
    render "index"
  end
end
