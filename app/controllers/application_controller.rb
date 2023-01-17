class ApplicationController < ActionController::Base

  # ログイン後の画面遷移先を設定
  def after_sign_in_path_for(resource)
    case resource
    when Admin
      admin_path
    when PublicUser
      my_page_public_public_users_path
    when ArtistUser
      my_page_artist_artist_users_path
    end
  end

  # ログアウト後の画面遷移先を設定
  def after_sign_out_path_for(resource_or_scope)
    if resource_or_scope == :admin
      admin_session_path
    elsif resource_or_scope == :public_user
      root_path
    elsif resource_or_scope == :artist_user
      root_path
    end
  end
end
