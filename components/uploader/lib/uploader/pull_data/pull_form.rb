module Uploader
  module PullData
    class PullForm
        # https://jinshuju.net/api/v1/forms/xxx(表单token)/entries
      # https://jinshuju.net/api/v1/forms/xxx(表单token)/entries?next=xx（next值）
      BASE_ENTRIES_API="https://jinshuju.net/api/v1/forms/"
      attr_reader :form_identify, :sign_up_form

      def initialize( form_identify )
        @form_identify = form_identify
        @sign_up_form = find_form
      end

      def pull_form
        # loop curl data
        # if next, curl again
        # handle data
        loop_curl
      end

      private

      def loop_curl
        next_num = nil
        begin
          url = gen_next_url(next_num)
          results = send_request(url)
          next_num = results[:next]
          handle_results(results)
        end while next_num
      end

      def send_request(url)
        response = RestClient::Request.execute(
          {
            method: :get,
            url: url,
            headers: { Authorization: "Basic " + Base64::encode64(auth_details) }
          }
        )
        unless response_success?(response)
          raise "request fail, response code not eq 2**"
        end
        # response.to_str json: "{\"total\":7,\"count\":7,\"data\":[{\"serial_number\":1,...}, {..}..], \"next\":null}"
        # parse and deep_symbolize_keys: {:total=>7, :count=>7, :data=>[{:serial_number=>1...}..], :next=>nil}
        # data: sign up datum array
        # next: when not next, it will be nil.
        results = JSON.parse(response.to_str).deep_symbolize_keys
      end

      def response_success?(response)
        response && ( response.code.to_s.match(/^2/) )
      end

      def gen_next_url( next_num = nil )
        uri = URI(BASE_ENTRIES_API + form_identify + "/entries")
        if next_num
          uri.query = "next=#{next_num}"
        end
        uri.to_s
      end

      def auth_details
        ENV.fetch("JINSHUJU_API_KEY") + ":" + ENV.fetch("JINSHUJU_API_SECRET")
      end

      def handle_results(results)
        # data: [{:serial_number=>1, ...}...]

        data = results[:data]
        start_id = data.first[:serial_number].to_i
        end_id = data.last[:serial_number].to_i
        # get_jsj_range_array in db
        db_array = get_jsj_range_array_in_db(sign_up_form.id, start_id, end_id)

        # compare source_array with db array
        compare_source_with_db(data, db_array)



        # update diff
      end

      def find_form
        SignUp::SignUpForm.find_by(form_identify: form_identify)
      end

      def get_jsj_range_array_in_db(sign_up_form_id, start_id, end_id)
        SignUp::SignUpDatum.where( sign_up_form_id: sign_up_form_id ).and( SignUp::SignUpDatum.where( jsj_id: [start_id..end_id] ) )
      end

      def compare_source_with_db(source_array, db_array)
        compare_result = {}
        source_id_array = source_array.map {|item| item[:serial_number]}
        db_id_array = db_array.map {|item| item.entry[:serial_number]}
        compare_result[:intersection]
        # select extra in source, and create
        compare_result[:source_not_intersection]
        # select extra in db, and delete
        compare_result[:db_not_intersection]

      end

    end
  end
end
