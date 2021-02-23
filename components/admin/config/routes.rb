Admin::Engine.routes.draw do
  namespace :manager do
    resources :admins
    resources :sponsors


    
  end


end
