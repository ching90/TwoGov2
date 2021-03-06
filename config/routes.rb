Rails.application.routes.draw do

  # Search Bar
  get "search" => "pages#search"
  resources :posts
  resources :invitations
  #devise_for :users
  devise_for :users, :controllers => { :registrations => "registrations",
                                       :omniauth_callbacks => "users/omniauth_callbacks" }
  root to: 'pages#index'

  resources :users, only: [:show]  #important! place this after devise_for :users!
  resources :reviews

  # conversations
  resources :conversations do
      member do
        post :reply
        post :trash
        post :untrash
      end
  end
 # sylvia
#No route matches {:action=>"show", :controller=>"users/registrations"} missing required keys: [:id]
#<li><%= link_to "View Profile", user_registrations_path %></li>
#**************
  # devise_for :users, controllers: { 
  # #   sessions: 'users/sessions', 
  #    registrations: 'users/registrations'
  # }

  # devise_scope :user do
  #   get 'users/:id', to:  "users/registrations#show" , :as => "user_registrations"
  #   get 'users/edit/:id', to:  "users/registrations#edit" , :as => "edit_user_registrations"
  # end

  # root to: 'pages#index'

  get '/post/listing', :to => "posts#listing"
  get '/invitation/:id/confirm', :to => "invitations#confirm"
  get '/invitation/:id/decline', :to => "invitations#decline"
  get '/users/:id/buddy', :to => "users#buddy"

    # mailbox folder routes
  get "mailbox/inbox" => "mailbox#inbox", as: :mailbox_inbox
  get "mailbox/sent" => "mailbox#sent", as: :mailbox_sent
  get "mailbox/trash" => "mailbox#trash", as: :mailbox_trash
  #get 'users/:id', to:  "registrations#show" , :as => "user_registrations"
  #**************
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
