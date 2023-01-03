class Public::PublicUsersController < ApplicationController
  def show
    @public_user = current_public_user
    # TimeLineを表示するため、followしているユーザーのtopicsを取得
    @tl_topics = Topic.where(artist_user_id: current_public_user.artist_following_ids).order(created_at: :desc)
  end

  def public_profile
    @public_user = PublicUser.find(params[:public_user_id])

    @current_PublicUser_join = Join.where(public_user_id: current_public_user.id)
    @PublicUser_join = Join.where(public_user_id: @public_user.id)
    unless @public_user.id == current_public_user.id
      @current_PublicUser_join.each do |current_public|
        @PublicUser_join.each do |other_public|
          if current_public.room_id == other_public.room_id then
            @isRoom = true
            @roomId = current_public.room_id
          end
        end
      end
      if @isRoom
      else
        @room = Room.new
        @join = Join.new
      end
    end
  end

  def edit
    @public_user = current_public_user
  end

  def update
    public_user = current_public_user
    public_user.update(public_user_params)
    redirect_to my_page_public_public_users_path
  end

  def unsubscribe
  end

  private

  def public_user_params
    params.require(:public_user).permit(:profile_image, :last_name, :first_name, :last_name_kana, :first_name_kana, :nickname, :introduction, :email)
  end
end
