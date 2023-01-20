class Admin::PublicUsersController < ApplicationController
  # 一般会員一覧
  def index
    # 退会済みの一般会員を指定し、indexページを表示させる
    if params[:no_active].present?
      @public_users = PublicUser.deleted
      @search_display = "退会済みのアカウント"
    else
      @public_users = PublicUser.all
    end
  end

  # キーワード検索アクション
  def search
    @public_users = PublicUser.search(params[:keyword])
    @keyword = params[:keyword]
    render "index"
  end

  # 一般会員詳細画面
  def show
    @public_user = PublicUser.find(params[:id])
  end

  # 一般会員情報編集画面
  def edit
    @public_user = PublicUser.find(params[:id])
  end

  # 一般会員情報更新アクション
  def update
    @public_user = PublicUser.find(params[:id])
    @public_user.update(public_user_params)
    redirect_to admin_public_user_path
  end

  private

  def public_user_params
    params.require(:public_user).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :nickname, :email, :is_deleted)
  end
end
