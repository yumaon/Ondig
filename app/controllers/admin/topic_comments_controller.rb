class Admin::TopicCommentsController < ApplicationController
  before_action :authenticate_admin!
  # コメント削除アクション
  def destroy
    TopicComment.find(params[:id]).destroy
    redirect_to admin_topic_path(params[:topic_id])
  end
end
