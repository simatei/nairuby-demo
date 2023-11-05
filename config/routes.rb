Rails.application.routes.draw do
  resources :events do
    resources :attendances, only: [:new, :create]
  end

  root 'events#index'
end
