Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  match '/404', to: 'errors#not_found', via: :all
  match '/422', to: 'errors#restricted_access', via: :all
  match '/500', to: 'errors#internal_server_error', via: :all

  root 'static_pages#home'

  get '/about_us', to: 'static_pages#about_us'
  get '/faq', to: 'static_pages#faq'
  get '/partners', to: 'static_pages#partners'
  get '/donate', to: 'static_pages#donate'
  get '/privacy_policy', to: 'static_pages#privacy_policy'
  get '/terms_and_conditions', to: 'static_pages#terms_and_conditions'
  get '/cookie_policy', to: 'static_pages#cookie_policy'

  get '/account_select', to: 'static_pages#account_select'
  get '/profile_review/:id', to: 'profile_reviews#show', as: 'profile_review'

  get '/adoptable_dogs', to: 'adoptable_dogs#index'
  get '/adoptable_dogs/:id', to: 'adoptable_dogs#show', as: 'adoptable_dog'

  get '/contacts', to: 'contacts#create'
  get '/contacts/new', to: 'contacts#new', as: 'new_contact'

  get '/successes', to: 'successes#index'

  get '/my_applications', to: 'adopter_applications#index'
  post 'create_my_application', to: 'adopter_applications#create'
  patch 'my_application', to: 'adopter_applications#update'

  post 'create_adoption', to: 'adoptions#create'

  delete 'attachments/:id/purge', to: 'attachments#purge', as: 'purge_attachment'

  resources :dogs, controller: 'organization_dogs'
  resources :adopter_applications, controller: 'adoption_application_reviews'

  devise_for :users, controllers: { registrations: 'registrations' }

  resource :adopter_profile, only: [:new, :create, :show, :edit, :update ], as: 'profile'
  resolve('adopter_profile') { [:adopter_profile] }

end
