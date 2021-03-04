module Uploader
  class SyncDatum
    def initialize(enroll_raw_datum)
      enroll_datum = EnrollDatum.new(enroll_raw_datum)
    end

    # compare with db, return compare result.

    # update db
      # update if not the same
      # else skip

      # if not find, create at db.

  end
end
