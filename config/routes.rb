Dreambop3::Application.routes.draw do
  namespace :admin do resources :manufacturers end

  resource :cart
  resources :orders do
    collection do
      post :paypal 
      get :paypal_complete 
    end
  end

  resources :manufacturers

  resource :credit_card

  resources :shipping_addresses

  match '/logout', :controller => 'sessions', :action => 'destroy', :as => 'logout'
  match '/login', :controller => 'sessions', :action => 'new', :as => 'login'
  match '/register', :controller => 'users', :action => 'create', :as => 'register'
  match '/signup', :controller => 'users', :action => 'new', :as => 'signup'
  match '/activate/:activation_code', :controller => 'users', :action => 'activate', :activation_code => nil, :as => 'activate'
  resources :users, :member => { :suspend => :put, :unsuspend => :put, :purge => :delete }
  match '/reset_password', :controller => 'users', :action => :reset_password, :as => 'reset_password'
  match '/change_password', :controller => 'users', :action => :change_password, :as => 'change_password'
  match '/search/post', :controller => 'search', :action => 'post', :via => 'post', :as => 'search_post'
  match '/search/:id', :controller => 'search', :action => 'show', :via => 'get', :as => 'search'
  match '/categories/:id', :controller => 'categories', :action => 'index', :as => 'categories'
  #map.manufacturer '/manufacturers/:id', :controller => 'manufacturers', :action => 'show'
  #map.manufacturers_index '/manufacturers', :controller => 'manufacturers', :action => 'index'
  match '/categories/sub/:id', :controller => 'categories', :action => 'sub', :as => 'categories_sub'
  match '/new', :controller => 'products', :action => 'new', :as => 'new'
  match '/featured', :controller => 'products', :action => 'featured', :as => 'featured'
  match '/top_sellers', :controller => 'products', :action => 'top_sellers', :as => 'top_sellers'
  match '/recommended', :controller => 'products', :action => 'recommended', :as => 'recommended'

  resource :session
  #map.resource :manufacturers

  match 'products/feed.:format', :controller => 'products', :action => 'feed'
  resources :products
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

  namespace :admin do
    resources :categories
    controller :categories do
      match 'categories(/:action(/:id(.:format)))'
    end
    resources :products
    controller :products do
      match 'products(/:action(/:id(.:format)))'
    end
    resources :manufacturers
    controller :manufacturers do
      match 'manufacturers(/:action(/:id(.:format)))'
    end
  end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => "welcome#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
  root :to => "products#index"
  match ':controller(/:action(/:id(.:format)))'
end
