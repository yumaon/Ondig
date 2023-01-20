Rails.application.routes.draw do

  # アーティスト会員用
  namespace :artist do
    resources :public_users, only:[:show] do
      post 'relationships' => 'relationships#public_follow'
      delete 'relationships' => 'relationships#public_unfollow'
    end
    resources :artist_users, only:[:index] do
      collection do
        get 'my_page' => 'artist_users#show'
        get 'my_page/favorite_topics' => 'favorites#index'
        get 'my_page/my_topics' => 'artist_users#my_topics'
        get 'information/edit' => 'artist_users#edit'
        patch 'information' => 'artist_users#update'
        get 'unsubscribe' => 'artist_users#unsubscribe'
        patch 'hide' => 'artist_users#hide'
        post 'rooms' => 'rooms#create', as: 'rooms_create'
        get 'rooms/:id' => 'rooms#show', as: 'rooms'
        post 'messages' => 'messages#create'
        get 'search' => 'artist_users#search'
      end

      member do
        get 'profile' => 'profiles#show'
        get 'profile/edit' => 'profiles#edit'
        patch 'profile' => 'profiles#update', as: 'profile_update'
      end
      resources :live_schedules, only:[:new, :create, :index, :edit, :update, :destroy]
      resources :items, only:[:new, :create, :index, :edit, :update, :destroy]
      resources :profile_topics, only:[:index]
      resources :rooms, only:[:index]
      # resource :relationships, only:[:create, :destroy]
      post 'relationships' => 'relationships#artist_follow'
      delete 'relationships' => 'relationships#artist_unfollow'
      get 'followings' => 'relationships#followings', as: 'followings'
      get 'followers' => 'relationships#followers', as: 'followers'
      # resources :favorites, only:[:index]
    end

    resources :genres, only:[:index, :create]
    resources :topics do
      resources :topic_comments, only:[:create, :destroy]
      resource :favorites, only:[:create, :destroy]
      collection do
        get 'search' => 'topics#search'
        delete ':id' => 'topics#from_index_destroy', as: 'from_index_destroy'
      end
    end
    resources :tags, only:[] do
      get 'topics', to: 'topics#tag_search'
    end
  end

  # 一般会員用
  scope module: :public do
    root to: 'homes#top'
    get 'about' => 'homes#about'
  end

  namespace :public do
    resources :public_users, only:[] do
      collection do
        get 'my_page' => 'public_users#show'
        get 'my_page/favorite_topics' => 'favorites#index'
        get 'information/edit' => 'public_users#edit'
        patch 'information' => 'public_users#update'
        get 'unsubscribe' => 'public_users#unsubscribe'
        patch 'hide' => 'public_users#hide'
        post 'rooms' => 'rooms#create', as: 'rooms_create'
        get 'rooms/:id' => 'rooms#show', as: 'rooms'
        post 'messages' => 'messages#create'
      end
      get 'profile' => 'public_users#public_profile'
      post 'relationships' => 'relationships#public_follow'
      delete 'relationships' => 'relationships#public_unfollow'
      get 'followings' => 'relationships#followings', as: 'followings'
      get 'followers' => 'relationships#followers', as: 'followers'
      # resources :favorites, only:[:index]
      resources :rooms, only:[:index]
    end
    resources :artist_users, only:[:index] do
      member do
        get 'profile' => 'profiles#show'
      end
      collection do
        get 'search' => 'artist_users#search'
      end
      resources :live_schedules, only:[:index]
      resources :items, only:[:index]
      resources :profile_topics, only:[:index]
      post 'relationships' => 'relationships#artist_follow'
      delete 'relationships' => 'relationships#artist_unfollow'
    end
    resources :topics, only:[:index, :show] do
      resources :topic_comments, only:[:create, :destroy]
      resource :favorites, only:[:create, :destroy]
      collection do
        get 'search' => 'topics#search'
      end
    end
    resources :tags, only:[] do
      get 'topics', to: 'topics#tag_search'
    end
  end

  # 管理者用
  namespace :admin do
    get '/' => 'homes#top'
    resources :public_users, only:[:index, :show, :edit, :update] do
      collection do
        get 'search' => 'public_users#search'
      end
    end
    resources :artist_users, only:[:index, :show, :edit, :update] do
      collection do
        get 'search' => 'artist_users#search'
      end
    end
    resources :genres, only:[:index, :edit, :create, :update, :destroy]
    resources :topics, only:[:index, :show, :destroy] do
      resources :topic_comments, only:[:destroy]
      collection do
        resources :tags, only:[:index, :destroy]
        get 'search' => 'topics#search'
      end
    end
    resources :tags, only:[] do
      get 'topics', to: 'topics#tag_search'
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
