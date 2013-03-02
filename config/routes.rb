H1bwiki::Application.routes.draw do

  resources :post_mentors
  resources :post_trainings
  resources :post_jobs
  resources :skills


  resources :post_trainings  
  resources :countries

  devise_for :users, :controllers => {:registrations => "registrations" } do
    get "registrations/new_jobseeker", :to => "registrations#new_jobseeker", :as => "new_jobseeker"
    get "registrations/new_employer", :to => "registrations#new_employer", :as => "new_employer"
  end

  get "static_pages/home"

  get "static_pages/about"

  get "static_pages/help"

  get "static_pages/contact"
  
  get "static_pages/post_main", :as =>"post_main"
  get "static_pages/posts", :as => "posts_view"
  match 'signup' => 'static_pages#signup'
  
  root :to => "static_pages#home"
end
