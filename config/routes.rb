Rails.application.routes.draw do

  mount Admin::Engine => '/', as: 'admin'
  # gems
  mount Account::Engine   => '/', as: 'account'
  # mount Frontend::Engine   => '/', as: 'frontend'

end
