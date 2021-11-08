Rails.application.routes.draw do

 #管理者のルート設定
  namespace :admin do
    root to: 'homes#top'
    resources :genres, only:[:index, :create, :edit, :update]
    resources :items, only:[:index, :new, :create, :show, :edit, :update]
    resources :customers, only:[:index, :show, :edit, :update]
    resources :orders, only:[:show, :update]
    resources :order_details, only:[:update]
  end

  devise_for :admin, controllers: {
    sessions: "admin/sessions"
  }


 #会員のルート設定

  scope module: :public do
    resources :items, only:[:index, :show]
    resource :customers, only:[:index, :edit, :update, :show] do
      collection do
        get 'unsubscribe'
        patch 'withdraw'
      end
    end
    resources :addresses, only:[:index, :edit, :create, :update, :destroy]
    resources :cart_items, only:[:index, :update, :destroy, :create] do
      collection do
        delete 'destroyall'
      end
    end

    resources :orders, only:[:new, :create, :index, :show] do
      collection do
        post 'confirm', to: 'orders#confirm'
        get 'thanks'
      end
    end

    root to: 'homes#top'
    get 'home/about', to: 'homes#about'

  end

  devise_for :customer, controllers: {
    registrations: 'public/registrations',
    sessions: "public/sessions"
  }

end