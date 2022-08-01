Rails.application.routes.draw do
  root 'static_pages#home'
  get '/account_select', to: 'static_pages#account_select'
  get 'profile_review', to: 'profile_reviews#show'

  devise_scope :user do
    get '/users/staff_sign_up'
  end

  devise_for :users, controllers: { registrations: 'registrations' }

  resource :adopter_profile, only: [:new, :create, :show, :edit, :update ], as: 'profile'
  resolve('adopter_profile') { [:adopter_profile] }

  resources :dogs, controller: 'organization_dogs'
end
