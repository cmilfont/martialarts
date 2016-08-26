Martialarts::Application.routes.draw do
  
  resources :martialarts

  root 'techniques#index'
  
  devise_for :users
  
  resources :users, :only => [:show, :api] do
    collection do
      post :api
    end
  end
  
  resources :techniques do
    collection do
      get :search
    end
    resources :videos, :only => [:create, :destroy]
  end

  resources :tags

end
