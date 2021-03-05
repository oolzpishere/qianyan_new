module Uploader
  class FormStruct
    attr_reader :sign_up_form, :form_struct, :name, :description, :fields
    def initialize(form_identify:, sign_up_form:)
      if sign_up_form
        @sign_up_form = sign_up_form
      elsif form_identify
        @sign_up_form = SignUp::SignUpForm.find_by(form_identify: form_identify)
      end

      @form_struct = parse_json(sign_up_form.form_struct).deep_symbolize_keys
      @name = form_struct[:name]
      @description = form_struct[:description]
      @fields = form_struct[:fields]
    end

    def method_name

    end


    private

    def parse_json(form_struct_json)
      if form_struct_json.is_a?(Hash)
        form_struct_json
      else
        JSON.parse(form_struct_json)
      end
    end

  end
end
