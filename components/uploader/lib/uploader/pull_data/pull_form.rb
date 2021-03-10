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

      def find_form
        SignUp::SignUpForm.find_by(form_identify: form_identify)
      end

      def loop_curl
        next_num = nil
        begin
          url = gen_next_url(next_num)
          results = send_request(url)
          next_num = results[:next]
          # handle_results(results)
          HandleResults.new(form_identify, results)
        end while next_num
      end

      # def handle_results(results)
      #   # data: [{:serial_number=>1, ...}...]
      #   data = results[:data]
      #   @source_enroll_data = data.map {|d| Uploader::EnrollDatum.new(d, form_identify)}
      #   start_id = data.first[:serial_number].to_i
      #   end_id = data.last[:serial_number].to_i
      #   # get_jsj_range_array in db
      #   db_array = get_jsj_range_array_in_db(sign_up_form.id, start_id, end_id)
      #   @db_enroll_data = db_array.map {|d| Uploader::EnrollDatum.new(d.entry, form_identify)}
      #   # compare source_array with db array
      #   compare_result = compare_source_with_db(data, db_array)
      #
      #   # update diff
      # end

      # def get_jsj_range_array_in_db(sign_up_form_id, start_id, end_id)
      #   SignUp::SignUpDatum.where( sign_up_form_id: sign_up_form_id ).and( SignUp::SignUpDatum.where( jsj_id: [start_id..end_id] ) )
      # end
      #
      # def compare_source_with_db(source_array, db_array)
      #   # D compare_result = {}
      #   source_id_array = source_array.map {|item| item[:serial_number]}
      #   db_id_array = db_array.map {|item| item.entry[:serial_number]}
      #   intersection_id_array = source_id_array & db_id_array
      #   # D compare_result[:intersection] = intersection_array
      #   # select extra in source, and create those
      #   @create_source_id_array = source_id_array - intersection_array
      #   # select extra in db, and delete those
      #   @delete_db_id_array = db_id_array - intersection_array
      #   compare_intersection(intersection_id_array)
      #   # D compare_result
      # end
      #
      # def compare_intersection(intersection_id_array)
      #   update_source_ids = []
      #   # select source_intersection_data
      #   source_intersection_data = select_source_intersection_data(intersection_id_array)
      #   # compare each entry of datum, return diff array.
      #   source_intersection_data.each do |source_datum|
      #     jsj_id = source_datum.jsj_id
      #     if (source_datum.entry != find_db_datum(jsj_id).entry)
      #       update_source_ids << jsj_id
      #     end
      #   end
      #   update_source_ids
      # end
      #
      # def select_source_intersection_data(intersection_id_array)
      #   source_enroll_data.select {
      #     |d| intersection_id_array.include?( d.jsj_id ) }
      # end
      #
      # def find_db_datum(jsj_id)
      #   db_enroll_data.find { |d| d.jsj_id == jsj_id }
      # end

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

      def parse_json(raw_entry)
        if raw_entry.is_a?(Hash)
          raw_entry.deep_symbolize_keys
        else
          JSON.parse(raw_entry).deep_symbolize_keys
        end
      end

    end
  end
end
