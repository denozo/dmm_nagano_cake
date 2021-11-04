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
    resources :addresses, only:[:index, :edit, :create, :update, :destroy]
    resources :cart_items, only:[:index, :update, :destroy, :create]
    
    resources :cart_items do
      collection do
        delete 'destroyall'
      end
    end
    
    resources :orders, only:[:new, :confirm, :thanks, :create, :index, :show]
    root to: 'homes#top'
    get 'home/about', to: 'homes#about'
  end

  #どの記述が適切か考える


  devise_for :admin, controllers: {
    sessions: "admin/sessions"
  }

  devise_for :customer


end