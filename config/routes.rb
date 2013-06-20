Muzkom::Application.routes.draw do

  root :to=>'pages#index'
  match '/login' => 'sessions#new', :as=>:login
  match '/logout' => 'sessions#destroy', :as=>:logout
  get "/payment_delivery" => "pages#delivery"
  get "/about_us" => "pages#show", :uri=>'about_us'
  get "/warranty" => "pages#show", :uri=>'warranty'
  get "/discount" => "pages#show", :uri=>'discount'
  get "/contacts" => "pages#show", :uri=>'contacts'
  get "/feed" => "pages#feed"
  put "/currency_change" => 'shop#change', :as=>:change_currency

  resources :sessions, :only => [:new, :create, :destroy]
  resources :feedbacks, :only => [:new, :create]

  resources :categories, :only=>[:show] do
    resources :brands, :only=>[:show]
  end

  resources :products, :only=>[:show, :find_by_code] do
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

  resource :cart, :controller => "cart" do
    get :index
    post :change
    put :add, :on => :member
    delete :delete, :on => :member
  end

  namespace :admin do
    root :to=>'index#index'
    resources :checkouts
    resources :pages
    resources :texts
    resources :videos
    resources :users, :only=>[:edit, :update]
    resources :slides
    resources :photos
    resources :feedbacks, :only => [:index, :destroy]
    resources :product_comments, :only => [:index, :destroy]
    resources :publication_comments, :only => [:index, :destroy]

    resources :banners do
      post :placement, :on => :member
    end

    resources :promotions do
      post :visibility, :on => :member
    end

    resources :publications do
      post :visibility, :on => :member
    end

    resources :brands do
      resources :currencies, :only=>[:index] do
        post :enter, :on => :collection
        delete :remove, :on => :collection
      end
      resources :products do
        post :visibility, :on => :member
        post :show_index, :on => :member
      end
      post :visibility, :on => :member
    end

    resources :subcategories do
      post :sort, :on => :collection
      post :move, :on => :collection
      resources :products do
        post :visibility, :on => :member
        post :show_index, :on => :member
      end
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
      get :switch, :on => :collection
    end


    resources :currencies, :only => [:index] do
      post :change, :on => :collection
    end

  end

  match "/page.php" => "pages#show", :uri=>'about_us'
  match "/contact.php" => "feedbacks#new"
  match "/cart.php" => "cart#index"
  match "/news.php" => "publications#index"
  match "/view_new.php" => "publications#show"
  match "/products.php" => "categories#show"
  match "/view_product.php" => "products#show"

  match ':controller(/:action(/:id))(.:format)'
end
