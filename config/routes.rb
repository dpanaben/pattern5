Rails.application.routes.draw do

  resources :portfolios do
    resources :sanitizes do
      member do
        post :changestatus #修改規則的on/off
        post :takeit #從admin規則抓資料
      end
    end
  end
  devise_for :users, :controllers => { omniauth_callbacks: 'users/omniauth_callbacks', sessions: 'users/sessions' }
  resources :visitors
  resources :users

  resources :posts do
    member do
      post :undo #單筆文章的undo功能
      post :brew #單筆文章的brew功能
      get :result #BREW完之後顯示結果
      post :publish
    end
    collection do
      get :history #抓全部post的history
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  #For log in user root to posts index, visitors go to visitors index
  authenticated :user do
    root to: 'posts#index', as: :authenticated_root
  end
  root to: 'visitors#new'
end
