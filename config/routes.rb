Rails.application.routes.draw do
  
  devise_for :customers
  
  # get 'items/index'
  # get 'items/new'
  # get 'items/create'
  # get 'items/show'
  # get 'items/edit'
  # get 'items/update'
  
  devise_for :admin, controllers: {
    sessions: "admin/sessions"
  }
  
  namespace :admin do
    root to: 'homes#top'
    resources :genres, only:[:index, :create, :edit, :update]
    resources :items, only:[:index, :new, :create, :show, :edit, :update]
  end
  
  namespace :public do
    resources :items, only:[:index, :show]
  end
  
end