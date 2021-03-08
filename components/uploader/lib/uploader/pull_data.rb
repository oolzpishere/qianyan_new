module Uploader
  module PullData
    # https://jinshuju.net/api/v1/forms/xxx(表单token)/entries
    # https://jinshuju.net/api/v1/forms/xxx(表单token)/entries?next=xx（next值）
    BASE_ENTRIES_API="https://jinshuju.net/api/v1/forms/"
    def self.pull_all
      SignUp::SignUpForm.all
    end

    def self.pull_form(form_identify)
      # loop curl data
      # if next, curl again
      # handle data
      loop_curl(form_identify)
    end

    private

    def self.loop_curl(form_identify)
      next_num = nil
      begin
        url = gen_next_url(form_identify, next_num)
        results = send_request(url)
        handle_results(results)
      end while next_num
    end

    def self.send_request(url)
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

      results = JSON.parse(response.to_str).deep_symbolize_keys
      results[:total]
      results[:count]
      # data: sign up datum array
      results[:data]
      next_num = results[:next]
    end

    def self.response_success?(response)
      response && ( response.code.to_s.match(/^2/) )
    end

    def self.gen_next_url(form_identify, next_num = nil)
      uri = URI(BASE_ENTRIES_API + form_identify + "/entries")
      if next_num
        uri.query = "next=#{next_num}"
      end
      uri.to_s
    end

    def self.auth_details
      ENV.fetch("JINSHUJU_API_KEY") + ":" + ENV.fetch("JINSHUJU_API_SECRET")
    end



  end
end
