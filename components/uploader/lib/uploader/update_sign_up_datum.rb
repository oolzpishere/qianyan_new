module Uploader
  module UpdateSignUpDatum
    # update to db
    def self.update_to_db(enroll_datum)
      params = enroll_datum.to_param
      SignUp::SignUpDatum.update(params)
    end

    def self.create_to_db(enroll_datum)
      
    end

  end
end
