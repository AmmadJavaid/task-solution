Rails.application.routes.draw do
  devise_for :users,
             controllers: {
              sessions: 'v1/users/sessions',
              registrations: 'v1/users/registrations'
            }

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
