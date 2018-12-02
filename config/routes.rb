Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  resources :projects
  resources :tasks
  resources :comments

  root to: 'projects#index'
end
