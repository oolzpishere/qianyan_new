module Uploader
  module SyncDatum

    def self.sync_db(enroll_raw_datum)
      enroll_datum = SyncDatum::EnrollDatum.new(enroll_raw_datum)
      # compare with db, return compare result.
      sign_up_datum_compare = SignUpDatumCompareWithDb.new(enroll_datum)

      exist = sign_up_datum_compare.exist_in_db?
      same = sign_up_datum_compare.entry_same_with_db？
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
      Uploader::UpdateSignUpDatum.update_to_db(enroll_datum)
    end

    def self.create_to_db(enroll_datum)
      Uploader::UpdateSignUpDatum.create_to_db(enroll_datum)
    end

  end
end
