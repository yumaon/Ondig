class Admin::TopicsController < ApplicationController
  # Topics一覧
  def index
    @topics = Topic.all
    @tag_lists = Tag.all
  end

  def show
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
