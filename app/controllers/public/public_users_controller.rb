class Public::PublicUsersController < ApplicationController
  # Mypage
  def show
    @public_user = current_public_user
    # TimeLineを表示するため、followしている退会していないユーザーのtopicsを取得
    @topics = Topic.active_topics.where(artist_user_id: current_public_user.artist_following_ids).order(created_at: :desc)
  end

  # 一般会員プロフィール画面
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

  # 登録情報編集画面
  def edit
    @public_user = current_public_user
  end

  # 登録情報更新
  def update
    public_user = current_public_user
    # ログイン中のユーザーがゲストユーザーの場合はニックネームとメールアドレス以外を更新可能にする。
    if public_user.email == 'guest@example.com'
      flash[:notice] = "ゲストユーザーのため、ニックネーム、メールアドレス以外を更新しました。"
      public_user.update(params.require(:public_user).permit(:profile_image, :last_name, :first_name, :last_name_kana, :first_name_kana, :introduction))
      redirect_to  my_page_public_public_users_path
    else
      flash[:notice] = "登録情報を編集しました。"
      public_user.update(public_user_params)
      redirect_to my_page_public_public_users_path
    end
  end

  # 退会確認画面
  def unsubscribe
    @public_user = current_public_user
  end

  # 退会処理(論理削除)
  def hide
    @public_user = current_public_user
    @public_user.update(is_deleted: true)
    reset_session
    redirect_to root_path
  end

  private

  def public_user_params
    params.require(:public_user).permit(:profile_image, :last_name, :first_name, :last_name_kana, :first_name_kana, :nickname, :introduction, :email)
  end
end
