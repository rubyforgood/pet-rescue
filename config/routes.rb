Rails.application.routes.draw do
  root 'static_pages#home'
  get '/account_select', to: 'static_pages#account_select'
  get '/profile_review', to: 'profile_reviews#show'
  get '/adoptable_dogs', to: 'adoptable_dogs#index'
  get '/adoptable_dogs/:id', to: 'adoptable_dogs#show', as: 'adoptable_dog'
  get 'my_adoption_applications', to: 'adopter_applications#index'
  post 'create_adoption_application', to: 'adopter_applications#create'
  delete 'destroy_adoption_application', to: 'adopter_applications#destroy'

  resources :dogs, controller: 'organization_dogs'

  # devise_scope :user do
  #   get '/users/staff_sign_up'
  # end

  devise_for :users, controllers: { registrations: 'registrations' }

  resource :adopter_profile, only: [:new, :create, :show, :edit, :update ], as: 'profile'
  resolve('adopter_profile') { [:adopter_profile] }

end
