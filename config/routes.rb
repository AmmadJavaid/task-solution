Rails.application.routes.draw do
  namespace :v1 do
    resources :users, only: [:index, :show] do
      member do
        patch :update_profile
      end
    end

    resources :posts do
      resources :comments, only: [:create, :update, :destroy]
    end
  end
end
