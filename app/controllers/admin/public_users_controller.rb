class Admin::PublicUsersController < ApplicationController
  def index
    @public_users = PublicUser.all
  end

  def show
    @public_user = PublicUser.find(params[:id])
  end

  def edit
    @public_user = PublicUser.find(params[:id])
  end

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
