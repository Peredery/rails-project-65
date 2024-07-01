# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  # Defines the root path route ("/")
  scope module: 'web' do
    root 'bulletins#index'
    post 'auth/:provider', to: 'auth#request', as: :auth_request
    delete 'auth/logout', to: 'auth#destroy'
    get 'auth/:provider/callback', to: 'auth#callback', as: :callback_auth

    resource :profile, only: :show

    resources :bulletins do
      member do
        patch :to_moderate
        patch :archive
      end
    end

    namespace :admin do
      root 'bulletins#index', filter_state: :under_moderation
      resources :bulletins, only: :index, filter_state: :all do
        member do
          patch :publish
          patch :archive
          patch :reject
        end
      end
      resources :categories, except: :show
    end
  end
end
