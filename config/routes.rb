# coding: utf-8
Rails.application.routes.draw do

  get 'admin/index'
  get 'build/index'
  resources :read_alouds, only: [:index, :chart]
  get 'read_alouds/chart'
  get 'course/create'
  post 'course/store'
  resources :course, only: [:edit, :update, :destroy]
  get 'home/course'
  resources :users
  root "home#index"
  
  resources :sessions, only: [:new, :create, :destroy] 
  get "signup", to: "users#new", as: "signup"
  get "login", to: "sessions#new", as: "login"
  get "logout", to: "sessions#destroy", as: "logout"
  resources :write_fr_dics, only:[:index, :public]
  resources :password_resets

  get 'write_fr_dics/public'
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
end
