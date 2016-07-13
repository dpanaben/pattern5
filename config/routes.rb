Rails.application.routes.draw do

  resources :sanitizes do
    member do
      post :changestatus #修改規則的on/off
    end
  end

  resources :posts do
    member do
      post :undo #單筆文章的undo功能
      post :brew #單筆文章的brew功能
      get :result #BREW完之後顯示結果
    end
    collection do
      get :history #抓全部post的history
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'posts#index'
end
