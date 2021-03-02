module SignUp
  class SignUpForm < ApplicationRecord
    self.table_name = :sign_up_forms

    has_many :sign_up_data
  end
end
