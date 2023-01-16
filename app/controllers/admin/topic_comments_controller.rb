class Admin::TopicCommentsController < ApplicationController
  # コメント削除アクション
  def destroy
    TopicComment.find(params[:id]).destroy
    redirect_to admin_topic_path(params[:topic_id])
  end
end
