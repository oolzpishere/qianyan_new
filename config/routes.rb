Rails.application.routes.draw do

  mount Admin::Engine => '/', as: 'admin'
  mount SignUp::Engine   => '/', as: 'sign_up'
  mount Uploader::Engine   => '/', as: 'uploader'


  # gems
  # devise_for :admins, module: 'devise', class_name: "Account::Admin", only: :sessions
  mount Account::Engine   => '/', as: 'account'
  # mount Frontend::Engine   => '/', as: 'frontend'

end
