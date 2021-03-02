module SignUp
  class SignUpDatum < ApplicationRecord
    self.table_name = :sign_up_data

    has_many :stream_codes

  end
end
