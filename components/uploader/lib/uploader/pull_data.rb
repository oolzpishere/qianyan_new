module Uploader
  module PullData
    def self.pull_all
      SignUp::SignUpForm.all
    end

    def self.pull_form(form_identify)
      PullForm.new(form_identify).pull_form
    end

    private

  end
end
