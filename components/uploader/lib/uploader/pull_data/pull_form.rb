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
          HandleResults.new(form_identify, results).invoke
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
