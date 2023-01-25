# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  before_action :public_user_state, only:[:create]

  # 一般会員ゲストログイン
  def guest_sign_in
    public_user = PublicUser.guest
    sign_in public_user
    redirect_to my_page_public_public_users_path, notice: 'ゲストユーザーとしてログインしました。'
  end

  protected
  # 退会しているかを判断する
  def public_user_state
    # 入力されたemailからアカウントを一件取得する
    @public_user = PublicUser.find_by(email: params[:public_user][:email])
    # アカウントを取得できなかった場合はこのメソッドを終了する
    return if !@public_user
    # 取得したアカウントのパスワードと入力されたパスワードが一致しているか、かつ、is_deletedの値がtrueである場合
    if @public_user.valid_password?(params[:public_user][:password]) && (@public_user.is_deleted == true)
      redirect_to new_public_user_registration_path
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
