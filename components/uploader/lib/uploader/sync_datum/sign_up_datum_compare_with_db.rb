module Uploader
  module SyncDatum
    class SignUpDatumCompareWithDb
      attr_reader :exist_in_db, :entry_same_with_db
      def initialize(enroll_datum)
        @exist_in_db ||= false
        @entry_same_with_db ||= false

        compare_with_db(enroll_datum)
      end

      # 根据sign_up_form_id and jsj_id, find from db, then compare entry
      def compare_with_db(enroll_datum)
        db_sign_up_datum = find_on_db(enroll_datum)
        # if not finded, then return
        return unless db_sign_up_datum
        # if finded,then compare
        # results: exist, exist and same, exist not same, not exist
        compare_with_db_entry(enroll_datum, db_sign_up_datum)
      end

      # def exist_in_db?
      #   exist_in_db
      # end
      #
      # def entry_same_with_db?
      #   entry_same_with_db
      # end

      private

      def find_on_db(enroll_datum)
        datum = SignUp::SignUpDatum.find_by(
          sign_up_form_id: enroll_datum.sign_up_form.id,
          jsj_id: enroll_datum.jsj_id
        )
        if datum
          @exist_in_db = true
        end
        datum
      end

      def compare_with_db_entry(enroll_datum, db_sign_up_datum)
        if enroll_datum.entry == db_sign_up_datum.entry
          @entry_same_with_db = true
        end
      end

    end
  end
end
