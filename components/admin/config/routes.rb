Admin::Engine.routes.draw do
  namespace :manager do
    resources :admins
    resources :sponsors



  end


end

Account::Engine.routes.draw do
  devise_for :admins, module: 'devise', class_name: "Account::Admin", only: :sessions
end
