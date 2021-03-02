module SignUp
  class StreamCode < ApplicationRecord
    self.table_name = :stream_codes

    belongs_to :sign_up_form
    belongs_to :conference
  end
end
