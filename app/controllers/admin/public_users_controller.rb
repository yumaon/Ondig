class Admin::PublicUsersController < ApplicationController
  def index
    @public_users = PublicUser.all
  end

  def show
  end

  def edit
  end
end
