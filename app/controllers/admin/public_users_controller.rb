class Admin::PublicUsersController < ApplicationController
  def index
    @public_users = PublicUser.all
  end

  def show
    @public_user = PublicUser.find(params[:id])
  end

  def edit
  end
end
