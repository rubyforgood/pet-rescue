Rails.application.routes.draw do
  devise_scope :user do
    get '/users/staff_sign_up' 
  end
  
  devise_for :users, controllers: { registrations: 'registrations' }

  root 'static_pages#home'

  resource :adopter_profile, only: [:new, :create, :show, :edit, :update ], as: 'profile'
  resolve('adopter_profile') { [:adopter_profile] }
end
