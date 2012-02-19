Muzkom::Application.routes.draw do
  
  root :to=>'pages#index'
  match '/login' => 'sessions#new', :as=>:login
  match '/logout' => 'sessions#destroy', :as=>:logout
  get "/payment_delivery" => "pages#delivery"
  get "/about_us" => "pages#show", :uri=>'about_us'
  get "/warranty" => "pages#show", :uri=>'warranty'
  get "/discount" => "pages#show", :uri=>'discount'
  get "/contacts" => "pages#show", :uri=>'contacts'
  
  resources :sessions, :only=>[:new, :create, :destroy]
  
  resources :categories, :only=>[:show] do
    resources :brands, :only=>[:show]
  end
  
  resources :products, :only=>[:show] do
    resources :product_comments, :only=>[:create]
    get :withdrawn, :on => :collection
  end
  
  resources :brands, :only=>[:show] do
    get :withdrawn, :on => :collection
  end
  
  resources :publications, :only=>[:index, :show] do
    resources :publication_comments, :only=>[:create]
  end
  resources :promotions, :only=>[:index, :show]
  resources :checkouts, :only=>[:new, :create]
  
  put "/currency_change" => 'shop#change', :as=>:change_currency
  get 'cart' => 'cart#index', :as =>:cart
  put 'cart/add/:id' => 'cart#add', :as => :add_to_cart
  delete 'cart/delete/:id' => 'cart#delete', :as => :delete_from_cart
  delete 'cart/empty' => 'cart#empty', :as =>:empty_cart
  
  namespace :admin do
    root :to=>'index#index'
    resources :checkouts
    resources :currencies
    resources :pages
    resources :texts
    resources :videos
    resources :users, :only=>[:edit, :update]
    resources :slides
    resources :banners
    resources :photos
    resources :product_comments, :only => [:index, :destroy]
    resources :publication_comments, :only => [:index, :destroy]
    
    resources :promotions do
      post :visibility, :on => :member
    end
    
    resources :publications do
      post :visibility, :on => :member
    end
    
    resources :brands do
      resources :currencies
      post :visibility, :on => :member
    end
    
    resources :categories do
      post :visibility, :on => :member
      post :sort, :on => :collection
      resources :subcategories do
          post :visibility, :on => :member
      end
    end
    
    resources :products do
      post :visibility, :on => :member
      post :show_index, :on => :member
    end
    
    resources :subcategories do 
      post :sort, :on => :collection
      post :move, :on => :collection
      resources :products do
        post :visibility, :on => :member
        post :show_index, :on => :member
      end
    end
  end
  
  get "/view_product.php" => "products#show"

end
