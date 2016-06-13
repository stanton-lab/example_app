Rails.application.routes.draw do

  devise_for :managers, only: []

  as :manager do
    get 'login', to: 'manager/sessions#new'
    post 'login', to: 'manager/sessions#create'
    delete 'logout', to: 'manager/sessions#destroy'
  end

  resources :clients, except: :show do
    resources :avatars, controller: 'avatars', only: [:create] do
      delete :destroy, on: :collection
      patch :crop, on: :collection
    end
  end

  resources :works
  resources :projects do
    resources :comments, only: [:create, :destroy]
    resources :avatars, controller: 'avatars', only: [:create] do
      delete :destroy, on: :collection
      patch :crop, on: :collection
    end
  end
  resources :currencies, except: [:show, :new] do
    match :update_all, via: [:patch], on: :collection
  end


  resources :periods, only: [:index, :create]

  resources :departments, except: :show
  resources :managers, except: :show do
    resources :avatars, controller: 'avatars', only: [:create] do
      delete :destroy, on: :collection
      patch :crop, on: :collection
    end
  end

  root to: 'dashboard#index'

end
