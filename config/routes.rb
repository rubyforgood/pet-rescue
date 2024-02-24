Rails.application.routes.draw do
  resources :checklist_template_items

  devise_for :users, controllers: {
    registrations: "registrations",
    sessions: "users/sessions",
    invitations: "organizations/invitations"
  }

  resources :adoptable_pets, only: [:index, :show]
  resource :adopter_profile, except: :destroy, as: "profile"
  resources :checklist_templates
  resources :donations, only: [:create]

  scope module: :organizations do
    resource :organization_profile, only: %i[edit update]

    resources :home, only: [:index]
    resources :pets do
      resources :tasks, only: [:new, :create, :edit, :update, :destroy]
      post "attach_images", on: :member, to: "pets#attach_images"
      post "attach_files", on: :member, to: "pets#attach_files"
    end
    resources :default_pet_tasks
    resources :dashboard, only: [:index]
    resources :adoption_application_reviews, only: [:index, :edit, :update]
    resources :foster_application_reviews, only: [:index]
    resources :staff do
      post "deactivate", to: "staff#deactivate"
      post "activate", to: "staff#activate"
      post "update_activation", to: "staff#update_activation"
    end
  end

  resources :profile_reviews, only: [:show]

  resources :countries, only: [] do
    resources :states, only: [:index]
  end

  match "/404", to: "errors#not_found", via: :all
  match "/422", to: "errors#restricted_access", via: :all
  match "/500", to: "errors#internal_server_error", via: :all

  root "root#index"
  get "/about_us", to: "static_pages#about_us"
  get "/faq", to: "static_pages#faq"
  get "/partners", to: "static_pages#partners"
  get "/donate", to: "static_pages#donate"
  get "/privacy_policy", to: "static_pages#privacy_policy"
  get "/terms_and_conditions", to: "static_pages#terms_and_conditions"
  get "/cookie_policy", to: "static_pages#cookie_policy"

  resources :adopter_applications, path: "applications",
    only: %i[index create update]

  post "create_adoption", to: "matches#create"
  delete "revoke_adoption", to: "matches#delete"

  get "/contacts", to: "contacts#create"
  get "/contacts/new", to: "contacts#new", as: "new_contact"

  delete "attachments/:id/purge", to: "attachments#purge", as: "purge_attachment"

  resolve("adopter_profile") { [:adopter_profile] }
end
