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
  resources :user_sessions
  resources :password_resets
  resources :user_audits

  resources :toil_requests
  resources :spend_toils
  resources :part_days, only: [:index, :show, :edit, :update, :destroy]

  #admin routes
  get '/reporting/approved_request/' => 'homepage#approved_select', :as => :approved_select
  get '/reporting/approved_request/:start_date/:end_date' => 'homepage#approved_filter', :as => :approved_filter

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



  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
