Rails.application.routes.draw do
  # 管理者用
  devise_for :admin,skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  # アーティスト会員用
  devise_for :artist_users,skip: [:passwords], controllers: {
    registrations: "artist/registrations",
    sessions: "artist/sessions"
  }

  # 一般会員用
  devise_for :public_users,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions"
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
