Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations' }

  root 'static_pages#home'

  resources :adopter_profiles
end
