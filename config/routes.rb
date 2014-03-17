Enerleave::Application.routes.draw do
  root 'leave_requests#index'

  resources :users do

  end
  resources :user_sessions

  resources :toil_requests
  resources :spend_toils

  #user sessions
  get 'export' => 'leave_requests#export', :as => :export
  get 'import_data' => 'leave_requests#import_data', :as => :import_data
  get 'login' => 'user_sessions#new', :as => :login
  post 'logout' => 'user_sessions#destroy', :as => :logout

  #user routes
  get '/users/:id/role' => 'users#role', :as => :role_user
  get '/users/:id/toil' => 'users#toil', :as => :user_toil
  get '/users/:id/leave' => 'users#leave', :as => :user_leave
  get '/users/:id/create_toil' => 'users#create_toil', :as => :admin_create_toil
  patch 'users/:id/update_role' => 'users#update_role'

  #leave_request routes
  resources :leave_requests do
    collection do
      post :import
      get :approvals
    end
  end
  get '/leave_requests/:id/approve_toil' => 'leave_requests#approve_leave', :as => :approve_leave

  #toil routes
  get '/spend_toils/:id/approve_toil' => 'spend_toils#approve_toil', :as => :approve_toil
  get '/toil_requests/:id/approve_toil' => 'toil_requests#approve_toil', :as => :approve_toil_request





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
