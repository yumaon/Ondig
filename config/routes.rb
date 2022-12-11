Rails.application.routes.draw do
  devise_for :admins
  devise_for :artist_users
  devise_for :public_users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
