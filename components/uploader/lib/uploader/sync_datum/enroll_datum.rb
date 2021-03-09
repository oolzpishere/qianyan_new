module Uploader
  module SyncDatum
    class EnrollDatum
      attr_reader :sign_up_form, :form_struct, :jsj_id, :entry, :use_data_type, :jsj_created_at, :jsj_updated_at, :phone, :email, :openid, :unionid

      def initialize(raw_entry, form_identify)
        @sign_up_form = SignUp::SignUpForm.find_by(form_identify: form_identify)
        @entry = parse_json(raw_entry)

        @form_struct = Uploader::FormStruct.new(sign_up_form: sign_up_form)

        @jsj_id = entry[:serial_number]
        # @use_data_type default set by sign_up_form.
        # @use_data_type = 'jsj_json'
        @jsj_created_at = entry[:created_at]
        @jsj_updated_at = entry[:updated_at]
        @openid = (entry[:x_field_weixin_openid] ? entry[:x_field_weixin_openid] : nil)
      end

      def to_params
        {
          sign_up_form_id: sign_up_form.id,
          jsj_id: jsj_id,
          entry: entry,
          # use_data_type: ,
          jsj_created_at: jsj_created_at,
          jsj_updated_at: jsj_updated_at,
          phone: phone,
          email: email,
          openid: openid,
          # unionid: ,
        }
      end

      private

      def parse_json(raw_entry)
        if raw_entry.is_a?(Hash)
          raw_entry.deep_symbolize_keys
        else
          JSON.parse(raw_entry).deep_symbolize_keys
        end
      end

      def phone
        @phone ||= entry[get_field_identify_by_label("手机")]
      end

      def email
        @email = entry[get_field_identify_by_label("邮箱")]
      end

      def get_field_identify_by_label(label)
        form_struct.find_by_label(label).field_identify
      end

    end
  end
end
