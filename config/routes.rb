Rails.application.routes.draw do

  # namespace :artist do
  #   get 'public_users/show'
  # end
  # アーティスト会員用
  namespace :artist do
    resources :public_users, only:[:show]
    resources :artist_users, only:[:index] do
      collection do
        get 'my_page' => 'artist_users#show'
        get 'my_page/favorite_topics' => 'favorites#index'
        get 'my_page/my_topics' => 'artist_users#my_topics'
        delete 'my_page/my_topics/:id' => 'artist_users#destroy', as: 'destroy_my_topic'
        get 'information/edit' => 'artist_users#edit'
        patch 'information' => 'artist_users#update'
        get 'unsubscribe' => 'artist_users#unsubscribe'
      end

      member do
        get 'profile' => 'profiles#show'
        get 'profile/edit' => 'profiles#edit'
        patch 'profile' => 'profiles#update', as: 'profile_update'
      end
      resources :live_schedules, only:[:new, :create, :index, :edit, :update, :destroy]
      resources :items, only:[:new, :create, :index, :edit, :update, :destroy]
      resources :profile_topics, only:[:index]
      # resources :favorites, only:[:index]
    end

    resources :genres, only:[:index, :create]
    resources :topics do
      resources :topic_comments, only:[:create, :destroy]
      resource :favorites, only:[:create, :destroy]
    end
  end

  # 一般会員用
  scope module: :public do
    root to: 'homes#top'
    get 'about' => 'homes#about'
  end

  namespace :public do
    resources :public_users, except:[:new, :show, :index, :edit, :create, :update, :destroy] do
      collection do
        get 'my_page' => 'public_users#show'
        get 'my_page/favorite_topics' => 'favorites#index'
        get 'information/edit' => 'public_users#edit'
        patch 'information' => 'public_users#update'
        get 'unsubscribe' => 'public_users#unsubscribe'
      end
      # resources :favorites, only:[:index]
    end
    resources :artist_users, only:[:index] do
      member do
        get 'profile' => 'profiles#show'
      end
      resources :live_schedules, only:[:index]
      resources :items, only:[:index]
      resources :profile_topics, only:[:index]
    end
    resources :topics, only:[:index, :show] do
      resources :topic_comments, only:[:create, :destroy]
      resource :favorites, only:[:create, :destroy]
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
