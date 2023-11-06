Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :events, defaults: { format: :json } do
        resources :attendances, only: [:new, :create]
      end
    end
  end

  resources :events do
    resources :attendances, only: [:new, :create]
  end

  root 'events#index'
end
