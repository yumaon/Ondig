class Admin::PublicUsersController < ApplicationController
  before_action :authenticate_admin!
  # 一般会員一覧
  def index
    # 退会済みの一般会員を指定し、indexページを表示させる
    if params[:no_active].present?
      @public_users = PublicUser.deleted.page(params[:page]).per(10)
      @search_display = "退会済みのアカウント"
    else
      @public_users = PublicUser.all.page(params[:page]).per(10)
    end
  end

  # キーワード検索アクション
  def search
    @public_users = PublicUser.search(params[:keyword]).page(params[:page]).per(10)
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

  # ゲストユーザーを削除
  def guest_delete
    public_user = PublicUser.find(params[:id])
    public_user.destroy
    redirect_to admin_public_users_path
  end

  private

  # ストロングパラメータ
  def public_user_params
    params.require(:public_user).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :nickname, :email, :is_deleted)
  end
end
