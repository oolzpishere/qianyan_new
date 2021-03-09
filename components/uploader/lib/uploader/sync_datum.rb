module Uploader
  module SyncDatum

    def self.sync_to_db(enroll_raw_datum)
      form_identify = enroll_raw_datum[:form]
      entry = enroll_raw_datum[:entry]
      enroll_datum = EnrollDatum.new(entry, form_identify)
      # compare with db, return compare result.
      sign_up_datum_compare = SignUpDatumCompareWithDb.new(enroll_datum)
      exist = sign_up_datum_compare.exist_in_db
      same = sign_up_datum_compare.entry_same_with_db
      if exist && same
        # skip, if entry is the same.
      elsif exist && !same
        # update, if exist and not the same.
        update_to_db(enroll_datum)
      elsif !exist
        # if not find, create at db.
        create_to_db(enroll_datum)
      end
    end

    private

    def self.update_to_db(enroll_datum)
      SignUp::SignUpDatum.update(enroll_datum.to_params)
    end

    def self.create_to_db(enroll_datum)
      SignUp::SignUpDatum.create(enroll_datum.to_params)
    end

  end
end
