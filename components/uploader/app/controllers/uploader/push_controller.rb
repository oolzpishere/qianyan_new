require_dependency "uploader/application_controller"

module Uploader
  class PushController < ApplicationController
    before_action :verify_pass_token, only: [:push_datum]

    def push_datum
      form_identify = params[:form_identify]
      # sync datum
      Uploader::SyncDatum.new(form_identify)

    end

    private

    def verify_pass_token
      if params[:pass_token] && ENV["QIANYAN_PASS"]
        secure_compare(params[:pass_token], ENV["QIANYAN_PASS"])
      else
        false
      end
    end

  end
end
