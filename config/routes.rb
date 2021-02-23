Rails.application.routes.draw do

  mount Admin::Engine => '/', as: 'admin'
  # gems
  # devise_for :admins, module: 'devise', class_name: "Account::Admin", only: :sessions
  mount Account::Engine   => '/', as: 'account'
  # mount Frontend::Engine   => '/', as: 'frontend'

end
