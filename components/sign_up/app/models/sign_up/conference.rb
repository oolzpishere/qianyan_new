module SignUp
  class Conference < ApplicationRecord
    self.table_name = :conference

    has_many :sign_up_forms


  end
end
