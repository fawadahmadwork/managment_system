Rails.application.routes.draw do
  root 'home#index'
  devise_for :employees
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users, confirmable: true
  get 'index', to: 'home#index'
end
