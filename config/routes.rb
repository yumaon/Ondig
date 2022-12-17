Rails.application.routes.draw do

  # namespace :artist do
  #   get 'artists/index'
  #   get 'artists/show'
  #   get 'artists/edit'
  # end
  # アーティスト会員用
  namespace :artist do
    get 'artist_users/my_page' => 'artist_users#show'
    get 'artist_users/information/edit' => 'artist_users#edit'
    patch 'artist_users/information' => 'artist_users#update'
    get 'artist_users/unsubscribe'

    resources :genres, only:[:index, :create]
  end
  scope module: :artist do
    resources :artists, only:[:index,] do
      member do
        get 'profile', action: :show
        get 'profile/edit', action: :edit
      end
    end
  end

  # 一般会員用
  scope module: :public do
    root to: 'homes#top'
    get 'about' => 'homes#about'
  end

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
