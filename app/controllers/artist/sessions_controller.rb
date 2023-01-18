# frozen_string_literal: true

class Artist::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  before_action :artist_user_state, only:[:create]

  protected
  # 退会しているかを判断する
  def artist_user_state
    # 入力されたemailからアカウントを一件取得する
    @artist_user = ArtistUser.find_by(email: params[:artist_user][:email])
    # アカウントを取得できなかった場合は、このメソッド終了する
    return if !@artist_user
    # 取得したアカウントのパスワードと入力されたパスワードが一致しているか、かつ、is_deletedの値がtrueである場合
    if @artist_user.valid_password?(params[:artist_user][:password]) && (@artist_user.is_deleted == true)
      redirect_to new_artist_user_registration_path
    end
  end
  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
