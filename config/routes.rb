Rails.application.routes.draw do
  

  namespace :public do
    get 'cart_items/index'
    get 'cart_items/update'
    get 'cart_items/destroy'
    get 'cart_items/destroyall'
    get 'cart_items/create'
  end
  
  namespace :public do
    get 'orders/new'
    get 'orders/confirm'
    get 'orders/thanks'
    get 'orders/create'
    get 'orders/index'
    get 'orders/show'
  end
  
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
  
  #どの記述が
  
  
  devise_for :admin, controllers: {
    sessions: "admin/sessions"
  }
  
  devise_for :customer
  
  
end