Rails.application.routes.draw do
  resources :checklist_template_items
  resources :checklist_templates
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  match "/404", to: "errors#not_found", via: :all
  match "/422", to: "errors#restricted_access", via: :all
  match "/500", to: "errors#internal_server_error", via: :all

  root "static_pages#home"
  get "/about_us", to: "static_pages#about_us"
  get "/faq", to: "static_pages#faq"
  get "/partners", to: "static_pages#partners"
  get "/donate", to: "static_pages#donate"
  get "/privacy_policy", to: "static_pages#privacy_policy"
  get "/terms_and_conditions", to: "static_pages#terms_and_conditions"
  get "/cookie_policy", to: "static_pages#cookie_policy"

  get "/profile_review/:id", to: "profile_reviews#show", as: "profile_review"

  get "/adoptable_pets", to: "adoptable_pets#index"
  get "/adoptable_pets/:id", to: "adoptable_pets#show", as: "adoptable_pet"

  get "/contacts", to: "contacts#create"
  get "/contacts/new", to: "contacts#new", as: "new_contact"

  get "/successes", to: "successes#index"

  get "/my_applications", to: "adopter_applications#index"
  post "create_my_application", to: "adopter_applications#create"
  patch "my_application", to: "adopter_applications#update"

  post "create_adoption", to: "matches#create"
  delete "revoke_adoption", to: "matches#delete"

  delete "attachments/:id/purge", to: "attachments#purge", as: "purge_attachment"

  resources :pets, controller: "organization_pets"
  resources :adopter_applications, only: [:index, :edit, :update], controller: "adoption_application_reviews"

  devise_for :users, controllers: {registrations: "registrations"}

  resource :adopter_profile, only: [:new, :create, :show, :edit, :update], as: "profile"
  resolve("adopter_profile") { [:adopter_profile] }

  post "/donations", to: "donations#create"
end
