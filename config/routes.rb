Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: "registrations",
    sessions: "users/sessions",
    invitations: "organizations/staff/invitations"
  }

  resources :donations, only: [:create]

  scope module: :organizations do
    resources :home, only: [:index]
    resources :adoptable_pets, only: [:index, :show]
    resources :faq, only: [:index]

    namespace :staff do
      resource :organization_profile, only: %i[edit update]
      resource :page_text, only: [:edit, :update]
      resources :profile_reviews, only: [:show]

      resources :pets do
        resources :tasks
        post "attach_images", on: :member, to: "pets#attach_images"
        post "attach_files", on: :member, to: "pets#attach_files"
      end

      resources :default_pet_tasks
      resources :faqs
      resources :dashboard, only: [:index]
      resources :matches, only: %i[create destroy]

      resources :adoption_application_reviews, only: [:index, :edit, :update]
      resources :foster_application_reviews, only: [:index]
      resources :staff do
        post "deactivate", to: "staff#deactivate"
        post "activate", to: "staff#activate"
        post "update_activation", to: "staff#update_activation"
      end

      resources :forms do
        resources :questions
      end

      delete "attachments/:id/purge", to: "attachments#purge", as: "purge_attachment"
    end

    namespace :adopter_fosterer do
      resource :profile, except: :destroy
      resources :dashboard, only: [:index]
      resources :adopter_applications, path: "applications", only: %i[index create update]
    end
  end

  resources :countries, only: [] do
    resources :states, only: [:index]
  end

  match "/404", to: "errors#not_found", via: :all
  match "/422", to: "errors#unprocessable_content", via: :all
  match "/500", to: "errors#internal_server_error", via: :all

  root "root#index"
  get "/about_us", to: "static_pages#about_us"
  get "/partners", to: "static_pages#partners"
  get "/donate", to: "static_pages#donate"
  get "/privacy_policy", to: "static_pages#privacy_policy"
  get "/terms_and_conditions", to: "static_pages#terms_and_conditions"
  get "/cookie_policy", to: "static_pages#cookie_policy"

  resources :contacts, only: [:new, :create]
end
