Rails.application.routes.draw do

  # アーティスト会員用
  namespace :artist do
    scope :artist_users do
      get 'my_page' => 'artist_users#show'
      get 'information/edit' => 'artist_users#edit'
      patch 'information' => 'artist_users#update'
      get 'unsubscribe' => 'artist_users#unsubscribe'
    end

    resources :genres, only:[:index, :create]
    resources :topics

    resources :artist_users, except:[:new, :show, :index, :edit, :update, :create, :destroy] do
      resources :live_schedules, only:[:new, :create, :index, :edit, :update, :destroy]
      resources :items, only:[:new, :create, :index, :edit, :update, :destroy]
    end
  end

  scope module: :artist do
    resources :artists, only:[:index,] do
      member do
        get 'profile', action: :show
        get 'profile/edit', action: :edit
        patch 'profile', action: :update, as: 'profile_update'
      end
    end
  end

  # 一般会員用
  scope module: :public do
    root to: 'homes#top'
    get 'about' => 'homes#about'
  end
  
  namespace :public do
    scope :public_users do
      get 'my_page' => 'public_users#show'
      get 'information/edit' => 'public_users#edit'
      patch 'information' => 'public_users#update'
      get 'unsubscribe' => 'public_users#unsubscribe'
    end
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
