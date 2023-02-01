class Public::MessagesController < ApplicationController
  # ダイレクトメッセージ送信（作成）
  def create
    if Join.where(public_user_id: current_public_user.id, room_id: params[:message][:room_id]).present?
      @message = Message.create(params.require(:message).permit(:public_user_id, :content, :room_id).merge(public_user_id: current_public_user.id))
    else
      flash[:alert] = "送信に失敗しました。"
    end
    redirect_to request.referer
  end
end
