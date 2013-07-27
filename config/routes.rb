require 'sidekiq/web'
OptionsIo::Application.routes.draw do
  match '/users/:id/feed', to: 'users#feed'
  root :to => 'users#new'
  resources :users
  resources :jobs, :only => [:show, :update]
  resources :sessions, :only => [:new, :create, :destroy]
  resources :user_tags
  resources :job_tags
  resources :notifications, :only => [:index,:destroy]

  match 'joblists/add', to: 'job_lists#add'
  match 'joblists/notes', to: 'job_lists#update_notes'
  match '/users/:id/queue', to: 'users#queue', as: 'queue_user'
  match '/auth/:provider/callback', to: 'omniauth_callbacks#all'
  match '/signout', to: 'sessions#destroy'
  match '/search', to: 'jobs#search'
  match '/location', to: 'static_pages#location'
  match '/add_to_queue/:id', to: 'jobs#add_to_queue', :as => 'add_to_queue'
  match '/remove_from_queue/:id', to: 'jobs#remove_from_queue', :as => 'remove_from_queue'
  match '/wizards/skills', to: 'wizards#skills', :as => 'wizard'
  match '/wizards/locations', to: 'wizards#locations', :as => 'wizard_location'
  match '/users/:id/feed', to: 'users#feed', :as => 'user_feed'
  match '/feed', to: 'users#feed_results', :as => 'feed_results'
  match '/get_job', to: 'jobs#get_job', :as => 'job_info'
  match '/search_tags', to: 'tags#search_skills', :as => 'search_tags'
  match '/search_all_tags', to: 'tags#search_all', :as => 'search_all_tags'
  match '/search_locations', to: 'tags#search_locations', :as => 'search_locations'
  match '/remove_from_queue', to: 'job_lists#destroy', :as => 'remove_from_queue'
  match '/user_locations', to: 'users#add_location', :as => 'user_location'
  mount Sidekiq::Web => '/sidekiq'

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
