Enerleave::Application.routes.draw do
  get 'users/export' => 'users#export', :as => :users_export

  resources :user_audits

  get "password_resets/create"
  get "password_resets/edit"
  get "password_resets/update"
  root 'homepage#index'

  #homepage controller
  get 'index' => 'homepage#index', :as => :homepage

  resources :users do

  end

  get '/travel_requests/:travel_request_id/travel_legs/:travel_leg_id/flights/:id/approve' => 'flights#approve', as: :approve_flight
  patch '/travel_requests/:travel_request_id/travel_legs/:travel_leg_id/flights/:id/approve' => 'flights#approval', as: :flight_approval
  get '/travel_requests/:travel_request_id/travel_legs/:travel_leg_id/accommodations/:id/approve' => 'accommodations#approve', as: :approve_accommodation
  patch '/travel_requests/:travel_request_id/travel_legs/:travel_leg_id/accommodations/:id/approve' => 'accommodations#approval', as: :accommodation_approval
  get '/travel_requests/:travel_request_id/travel_legs/:travel_leg_id/car_hires/:id/approve' => 'car_hires#approve', as: :approve_car_hire
  patch '/travel_requests/:travel_request_id/travel_legs/:travel_leg_id/car_hires/:id/approve' => 'car_hires#approval', as: :car_hire_approval

  post '/travel_requests/:id/' => 'travel_requests#lodge', as: :lodge_travel_request

  get '/travel_requests/:travel_request_id/travel_legs/:id/add_user' => 'travel_legs#add_user', as: :add_user
  post '/travel_requests/:travel_request_id/travel_legs/:id/add_user.:user_id' => 'travel_legs#approve_user', as: :approve_user

  get '/travel_requests/:travel_request_id/travel_legs/:id/remove_user' => 'travel_legs#remove_user', as: :remove_user
  post '/travel_requests/:travel_request_id/travel_legs/:id/remove_user.:user_id' => 'travel_legs#destroy_user', as: :destroy_user

  resources :user_sessions
  resources :password_resets
  resources :user_audits

  resources :toil_requests
  resources :spend_toils
  resources :part_days, only: [:index, :show, :edit, :update, :destroy]

  resources :travel_requests do
    resources :travel_legs do
      resources :car_hires
      resources :accommodations
      resources :flights
    end
  end

  #admin routes
  get '/reports/approved_select/' => 'leave_requests#approved_select', :as => :approved_select
  post '/reports/approved_request/' => 'leave_requests#approved_request', :as => :approved_request

  #user sessions
  get 'export' => 'leave_requests#export', :as => :export
  get 'import_data' => 'leave_requests#import_data', :as => :import_data
  get 'login' => 'user_sessions#new', :as => :login
  post 'logout' => 'user_sessions#destroy', :as => :logout

  #user routes
  get '/users/:id/role' => 'users#role', :as => :role_user
  get '/users/:id/manager_email' => 'users#manager_email', :as => :manager_email
  get '/users/:id/toil' => 'users#toil', :as => :user_toil
  get '/users/:id/leave' => 'users#leave', :as => :user_leave
  get '/users/:id/create_toil' => 'users#create_toil', :as => :admin_create_toil
  get '/users/:id/spend_toil' => 'users#spend_toil', :as => :admin_spend_toil
  patch 'users/:id/update_role' => 'users#update_role'
  patch 'users/:id/update_manager_email' => 'users#update_manager_email'
  post 'users/:id/create_as' => 'users#create_as', :as => :create_as
  get '/users/:id/leave_as' => 'users#leave_as', :as => :leave_as

  #leave_request routes
  resources :leave_requests do
    resources :part_days, only: [:new, :create]
    collection do
      post :import
      get :approvals
    end
  end
  get '/leave_requests/:id/approve_toil' => 'leave_requests#approve_leave', :as => :approve_leave
  get '/leave_requests/:id/unapprove_leave' => 'leave_requests#unapprove_leave', :as => :unapprove_leave
  get '/leave_requests/:id/delete' => 'leave_requests#delete', :as => :delete_leave
  post '/leave_requests/:id/delete' => 'leave_requests#destroy'

  #spend toil routes
  get '/spend_toils/:id/approve_toil' => 'spend_toils#approve_toil', :as => :approve_toil
  get '/spend_toils/:id/delete' => 'spend_toils#delete', :as => :delete_toil_spend
  post '/spend_toils/:id/delete' => 'spend_toils#destroy'

  #toil routes
  get '/toil_requests/:id/approve_toil' => 'toil_requests#approve_toil', :as => :approve_toil_request
  get '/toil_requests/:id/delete' => 'toil_requests#delete', :as => :delete_toil
  post '/toil_requests/:id/delete' => 'toil_requests#destroy'

  #help
  get '/help/' => 'help#index', :as => :help_index
  get '/help/login' => 'help#login', :as => :help_login
  get '/help/user' => 'help#user', :as => :help_user
  get '/help/leave' => 'help#leave', :as => :help_leave
  get '/help/toil' => 'help#toil', :as => :help_toil

end
