Rails.application.routes.draw do
  get 'sessions/create'

  get 'sessions/destroy'

  get 'home/show'

  get 'timesheet/index'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  #root 'login#index'

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

	#get '/login' => 'login#index', :as => :home

  #
  #timesheet related routes
  #
  #
  #get routes for timesheet entries
	get '/timesheet' => 'timesheet#index', :as => :timesheet
	#get '/timesheet/new' => 'timesheet#new', :as => :new_entry
  get '/timesheet/edit/:id' => 'timesheet#edit', :as => :edit_timesheet
  get '/timesheet/:employee_id' => 'timesheet#my_index', :as => :my_timesheet
  get '/timesheet/cascade/project' => 'timesheet#update_project'
  get 'timesheet/cascade/rate' => 'timesheet#update_rate'
  get 'timesheet/cascade/role' => 'timesheet#update_role'


  #post #routes for timesheet entries
  post '/timesheet/new' => 'timesheet#create'
  post '/timesheet/:id' => 'timesheet#create_inline'
  
  #put routes
  put '/timesheet.(:id)' => 'timesheet#update', :constraints => { :id => /[0-9A-Za-z\-\.]+/ }

  #delete routes
  delete '/timesheet/delete/:id' => 'timesheet#delete', 
  :as => :delete_entry

  #
  #routes related to the clients/projects/roles resources
  #
  #
  #get routes
  get '/details' => 'details#index', :as => :details

  #post routes
  post '/details/clients' => 'details#add_client'
  post '/details/projects' => 'details#add_project'
  post '/details/roles' => 'details#add_role'
  post '/details/currencies' => 'details#add_currency'

  #delete routes
  delete '/details/clients/:id' => 'details#delete_client'
  delete '/details/projects/:id' => 'details#delete_project'
  delete '/details/roles/:id' => 'details#delete_role'
  delete '/details/currencies/:id' => 'details#delete_currency'

  #put routes
  put '/client.(:id)' => 'details#update_client', :constraints => { :id => /[0-9A-Za-z\-\.]+/ }, :as => :client
  put '/project.(:id)' => 'details#update_project', :constraints => { :id => /[0-9A-Za-z\-\.]+/ }, :as => :project
  put '/role.(:id)' => 'details#update_role', :constraints => { :id => /[0-9A-Za-z\-\.]+/ }, :as => :role
  put '/currency.(:id)' => 'details#update_currency', :constraints => { :id => /[0-9A-Za-z\-\.]+/ }, :as => :currency


  #google auth routes
  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get 'signout', to: 'sessions#destroy', as: 'signout'

  resources :sessions, only: [:create, :destroy]
  resource :home, only: [:show]

  root to: "home#show"
end
