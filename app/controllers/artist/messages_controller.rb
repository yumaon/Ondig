class Artist::MessagesController < ApplicationController
  def create
    if Join.where(artist_user_id: current_artist_user.id, room_id: params[:message][:room_id]).present?
      @message = Message.create(params.require(:message).permit(:artist_user_id, :content, :room_id).merge(artist_user_id: current_artist_user.id))
    else
      flash[:alert] = "送信に失敗しました。"
    end
    redirect_to request.referer
  end
end
