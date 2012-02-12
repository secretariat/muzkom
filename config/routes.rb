Muzkom::Application.routes.draw do
  
  root :to=>'pages#index'
  resources :sessions, :only=>[:new, :create, :destroy]
  
  resources :categories, :only=>[:show] do
    resources :brands, :only=>[:show]
  end
  
  get 'products/' => 'products#index', :as=>:products_option
  
  resources :products, :only=>[:show] do
    resources :product_comments, :only=>[:create]
    get :withdrawn, :on => :collection
  end
  resources :brands, :only=>[:show] do
    get :withdrawn, :on => :collection
  end
  resources :publications, :only=>[:index, :show]
  resources :checkouts, :only=>[:new, :create]
  
  get 'checkout/finish' => 'checkouts#finish', :as=>:finish_checkout
  match '/login' => 'sessions#new', :as=>:login
  match '/logout' => 'sessions#destroy', :as=>:logout
  put "/currency_change" => 'shop#change', :as=>:change_currency
  get 'cart' => 'cart#index', :as =>:cart
  put 'cart/add/:id' => 'cart#add', :as => :add_to_cart
  delete 'cart/delete/:id' => 'cart#delete', :as => :delete_from_cart
  delete 'cart/empty' => 'cart#empty', :as =>:empty_cart
  
  namespace :admin do
    root :to=>'index#index'
    resources :categories
    resources :checkouts
    resources :pages
    resources :publications
    resources :promotions
    resources :products
    resources :slides
    resources :subcategories do 
    #  resources :products
    end
    resources :videos
    resources :users, :only=>[:edit, :update]
  end
  
  match "/:uri" => "pages#show"
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
  # match ':controller(/:action(/:id(.:format)))'
end
