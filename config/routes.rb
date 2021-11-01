Rails.application.routes.draw do
  

  namespace :admin do
    root to: 'homes#top'
    resources :genres, only:[:index, :create, :edit, :update]
    resources :items, only:[:index, :new, :create, :show, :edit, :update]
    resources :customers, only:[:index, :show, :edit, :update]
  end

  scope module: :public do
    resources :items, only:[:index, :show]
    resource :customers, only:[:index, :edit, :update, :show]
    resource :addresse, only:[:index, :edit, :create, :update, :destroy]
    root to: 'homes#top'
    get 'home/about', to: 'homes#about'
  end
  
  
  devise_for :admin, controllers: {
    sessions: "admin/sessions"
  }
  
  devise_for :customer
  
  
end