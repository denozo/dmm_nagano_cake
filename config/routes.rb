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
    resources :cart_items, only:[:index, :update, :destroy, :create] do
      collection do
        delete 'destroyall'
      end
    end
    
    resource :orders, only:[:new, :create, :index, :show] do
      collection do
        post 'confirm'
        get 'thanks'
      end
    end
      
    root to: 'homes#top'
    get 'home/about', to: 'homes#about'
  end


  devise_for :admin, controllers: {
    sessions: "admin/sessions"
  }

  devise_for :customer


end