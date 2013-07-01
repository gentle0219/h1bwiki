H1bwiki::Application.routes.draw do

  get "search_employer/h1bemployer"
  get "search_employer/h1bemp_name"


  resources :search_employer do
    member do
      post :rate
    end
    member do
      post :add_comment
    end
  end
  
  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'

  get "messagebox/inbox"
  get "messagebox/sent"
  get "messagebox/deleted"

  #match 'conversations/:id' => 'messagebox#sent'

  resources :jobseeker_jobs
  post 'jobseeker_jobs/preview'
  resources :jobseeker_trainings
  post 'jobseeker_trainings/preview'
  resources :jobseeker_mentors
  post 'jobseeker_mentors/preview'

  resources :post_jobs
  post 'post_jobs/preview'
  resources :post_trainings  
  post 'post_trainings/preview'
  resources :post_mentors
  post 'post_mentors/preview'
  
  resources :skills    
  resources :countries

  devise_for :users, :controllers => {:registrations => "registrations" } do
    get "registrations/new_jobseeker", :to => "registrations#new_jobseeker", :as => "new_jobseeker"
    get "registrations/new_employer", :to => "registrations#new_employer", :as => "new_employer"        
  end
  
  resources :conversations, only: [:index, :show, :new, :create] do
    member do
      post :reply
      post :trash
      post :untrash
    end
  end
  get "static_pages/home"
  get "static_pages/about"
  get "static_pages/help"
  get "static_pages/contact"  
  get "static_pages/post_main", :as =>"post_main"
  get "static_pages/posts", :as => "posts_view"

  get "static_pages/jobseeker_post_main", :as =>"jobseeker_post_main"
  get "static_pages/jobseeker_posts", :as => "jobseeker_posts"
  
  get "static_pages/search_home", :as => "search_home"

  match 'signup' => 'static_pages#signup'
  root :to => "static_pages#home"
end
