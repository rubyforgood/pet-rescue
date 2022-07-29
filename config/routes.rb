Rails.application.routes.draw do
  get '/account_select', to: 'static_pages#account_select'
  
  devise_scope :user do
    get '/users/staff_sign_up' 
  end
  
  devise_for :users, controllers: { registrations: 'registrations' }

  root 'static_pages#home'


  resource :adopter_profile, only: [:new, :create, :show, :edit, :update ], as: 'profile'
  resolve('adopter_profile') { [:adopter_profile] }
end
