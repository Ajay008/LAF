Rails.application.routes.draw do
  
  get 'lost_requests/new'
  post 'lost_requests/place_request' => 'lost_requests#place_request'
  resources :lost_requests
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  


  get 'users/login' => 'users#login'
  post 'users/home' => 'users#home'
  get 'users/home' => 'users#home'
  post 'users/logout' => 'users#logout'
  get 'users/new' => 'users#new'
  post 'users/add_user' => 'users#add_user'
  get 'users/found_list' => 'users#found_list'
  post 'users/found_list' => 'users#found_list'
  #root 'users#login'
  root 'users#index'
  resources :users  #, :only=>[:login, :new]



  get 'admins/login'
  get 'admins/home' => 'admins#home'
  post 'admins/home' => 'admins#home'
  post 'admins/logout' => 'admins#logout'
  get 'admins/approve' => 'admins#approve'
  get 'admins/reject' => 'admins#reject'
  get 'admins/show_match' => 'admins#show_match'
  get 'admins/notify' => 'admins#notify'
  get 'admins/return_item' => 'admins#return_item'
  get 'admins/return_item2' => 'admins#return_item2'
  get 'admins/added_items' => 'admins#added_items'
  post 'admins/added_items' => 'admins#added_items'
  resources :admins



  get 'found_items/new'
  post 'found_items/add_item' => 'found_items#add_item'
  resources :found_items
end
