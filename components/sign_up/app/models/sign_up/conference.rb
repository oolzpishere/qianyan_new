module SignUp
  class Conference < ApplicationRecord
    self.table_name = :conferences

    has_many :sign_up_forms


  end
end
