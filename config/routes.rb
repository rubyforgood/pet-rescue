Rails.application.routes.draw do
  root 'static_pages#home'
  get '/account_select', to: 'static_pages#account_select'
  get '/profile_review', to: 'profile_reviews#show'

  get '/adoptable_dogs', to: 'adoptable_dogs#index'
  get '/adoptable_dogs/:id', to: 'adoptable_dogs#show', as: 'adoptable_dog'

  post 'create_adopter_application', to: 'adopter_applications#create'
  delete 'destroy_adopter_application', to: 'adopter_applications#destroy'

  resources :dogs, controller: 'organization_dogs'
  resources :adopter_application, controller: 'adoption_application_reviews'

  devise_for :users, controllers: { registrations: 'registrations' }

  resource :adopter_profile, only: [:new, :create, :show, :edit, :update ], as: 'profile'
  resolve('adopter_profile') { [:adopter_profile] }

end
