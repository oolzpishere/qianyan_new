module Uploader
  module SyncDatum
    class EnrollDatum
      attr_reader :sign_up_form, :form_struct, :jsj_id, :entry, :use_data_type, :jsj_created_at, :jsj_updated_at, :phone, :email, :openid, :unionid
      def initialize(enroll_raw_datum)
        enroll_datum = parse_json(enroll_raw_datum).deep_symbolize_keys
        form_identify = enroll_datum[:form]

        @entry = enroll_datum[:entry]
        @sign_up_form = SignUp::SignUpForm.find_by(form_identify: form_identify)

        @form_struct = Uploader::FormStruct.new(sign_up_form: sign_up_form)

        @jsj_id = entry[:serial_number]
        # @use_data_type default set by sign_up_form.
        # @use_data_type = 'jsj_json'
        @jsj_created_at = entry.created_at
        @jsj_updated_at = entry.updated_at
        @openid = (entry.x_field_weixin_openid ? entry.x_field_weixin_openid : nil)
      end

      def to_sign_up_datum_params
        {
          sign_up_form_id: sign_up_form.id,
          jsj_id: jsj_id,
          entry: entry,
          # use_data_type: ,
          jsj_created_at: jsj_created_at,
          jsj_updated_at: jsj_updated_at,
          # phone: ,
          # email: ,
          openid: openid,
          # unionid: ,
        }
      end

      private

      def parse_json(enroll_raw_datum)
        if enroll_raw_datum.is_a?(Hash)
          enroll_raw_datum
        else
          JSON.parse(enroll_raw_datum)
        end
      end



    end
  end
end
