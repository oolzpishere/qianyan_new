module SignUp
  class StreamCode < ApplicationRecord
    self.table_name = :stream_codes

    t.belongs_to :sign_up_form
    t.belongs_to :conference
  end
end
