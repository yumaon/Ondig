class Artist::PublicUsersController < ApplicationController
  def show
    @public_user = PublicUser.find(params[:id])
  end
end
