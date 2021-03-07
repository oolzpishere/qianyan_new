module Uploader
  module FetchSignUpForm
    FORMS = [
      {name: "初中数学", conf_eng_name: "twenty_one_junior_high_math", form_identify: "yMGJyp", form_type: "jsj_json", all_use_data_type: "jsj_json"},
      {name: "初中语文", conf_eng_name: "twenty_one_junior_high_chinese", form_identify: "J8Dn9E", form_type: "jsj_json", all_use_data_type: "jsj_json"},
      {name: "初中英语", conf_eng_name: "twenty_one_junior_high_english", form_identify: "vutO2s", form_type: "jsj_json", all_use_data_type: "jsj_json"},
      {name: "小学数学", conf_eng_name: "twenty_one_primary_math", form_identify: "g2ywVL", form_type: "jsj_json", all_use_data_type: "jsj_json"},
      {name: "小学语文", conf_eng_name: "twenty_one_primary_chinese", form_identify: "nezjFn", form_type: "jsj_json", all_use_data_type: "jsj_json"},
      {name: "小学英语", conf_eng_name: "twenty_one_primary_english", form_identify: "iArAhn", form_type: "jsj_json", all_use_data_type: "jsj_json"},
    ]

    FORM_API_BASE_URL = "https://jinshuju.net/api/v1/forms/"

    def self.invoke_all
      FORMS.each do |hash|
        invoke( hash[:form_identify] )
      end
    end

    def self.invoke(form_identify)
      url = gen_url( form_identify )
      form_hash = find_pre_setting_form(form_identify)

      results = send_request(url)
      params = to_params(results).merge( pre_setting_params(form_hash) )
      # update, if exist and difference with db.
      sync_to_db(params)
    end

    private

    def self.send_request(url, payload = {}, options = {})
      response = RestClient::Request.execute(
        {
          method: :get,
          url: url,
          headers: { Authorization: "Basic " + Base64::encode64(auth_details) },
          payload: {}
        }.merge(options)
      )
      unless response_success?(response)
        raise "request fail, response code not eq 2**"
      end

      results = JSON.parse(response.to_str).deep_symbolize_keys
    end

    def self.response_success?(response)
      response && ( response.code.to_s.match(/^2/) )
    end

    def self.gen_url(form_identify)
      FORM_API_BASE_URL + form_identify
    end

    def self.auth_details
      ENV.fetch("JINSHUJU_API_KEY") + ":" + ENV.fetch("JINSHUJU_API_SECRET")
    end

    def self.pre_setting_params(form_hash)
      conf_id = find_conf( form_hash[:conf_eng_name] ).id
      {
       name: form_hash[:name],
       conference_id: conf_id,
       form_identify: form_hash[:form_identify],
       form_type: form_hash[:form_type],
       all_use_data_type: form_hash[:all_use_data_type]
     }
    end

    def self.to_params(results)
      {
        full_name: results[:name],
        description: results[:description],
        form_struct: results[:fields]
      }
    end

    def self.find_conf(conf_eng_name)
      SignUp::Conference.find_by(eng_name: conf_eng_name)
    end

    def self.find_pre_setting_form(form_identify)
      FORMS.find { |hash| hash[:form_identify] == form_identify }
    end

    def self.sync_to_db(params)
      new_form = SignUp::SignUpForm.new(params)
      form_identify = params[:form_identify]
      # if find in db
      org_form = find_in_db(form_identify)
      if !org_form
        new_form.save
      elsif org_form && !same_with_org_form?(new_form, org_form)
        # update_to_db
        update_to_db(params)
      elsif org_form && same_with_org_form?(new_form, org_form)
        #skip
      end
    end

    def self.find_in_db(form_identify)
      SignUp::SignUpForm.find_by(form_identify: form_identify)
    end

    def self.same_with_org_form?(new_form, org_form)
      rejects = ["id", "created_at", "updated_at"]
      new_form_hash = new_form.attributes.reject { |k,v| rejects.include?(k) }
      org_form_hash = org_form.attributes.reject { |k,v| rejects.include?(k) }
      new_form_hash == org_form_hash
    end

    def self.update_to_db(params)
      SignUp::SignUpForm.update(params)
    end

  end
end
