# coding: utf-8
Rails.application.routes.draw do

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  get 'pronunciation/index'
  get 'pronunciation/only_word'
  get 'pronunciation/list_word'
  get 'pronunciation/store_alphabet_trainning'
  get 'admin/index'
  get 'admin/report'
  get 'build/index'
  resources :read_alouds, only: [:index, :chart, :report]
  get 'read_alouds/chart'
  get 'read_alouds/report'
  get 'course/create'
  post 'course/store'
  resources :course, only: [:edit, :update, :destroy]
  get 'home/course'
  resources :users, only: [:new, :create, :update]
  root "home#index"
  
  resources :sessions, only: [:new, :create, :destroy] 
  get "signup", to: "users#new", as: "signup"
  get "login", to: "sessions#new", as: "login"
  get "logout", to: "sessions#destroy", as: "logout"
  resources :write_fr_dics, only: [:index, :public]
  resources :password_resets, only: [:edit, :update, :create, :new]

  get 'write_fr_dics/public'
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # Handle unavailable link
  get '*path' => redirect('/404_customize')

end
