require_dependency "uploader/application_controller"

module Uploader
  class PushController < ApplicationController
    before_action :verify_pass_token, only: [:push_datum]

    def push_datum
      form_identify = params[:form_identify]
      jsj_json = parse_json( request.body.read )
      # sync datum
      Uploader::SyncDatum.sync_to_db(jsj_json)
      render json: {:response => 'success'}, :status => 201
      # respond_to do |format|
      #   # format.html
      #   format.json { render json: {:response => 'success'}, :status => 201 }
      # end
    end

    private

    def verify_pass_token
      unless ( params[:pass_token] &&
        ENV.fetch("QIANYAN_PASS") &&
        ActiveSupport::SecurityUtils.secure_compare(
          params[:pass_token], ENV.fetch("QIANYAN_PASS")
        ) )
        # <203: Non-Authoritative Information>
        # password wrong, stop execution.
        head 203
      end
    end

    def parse_json(raw_datum)
      if raw_datum.is_a?(Hash)
        raw_datum
      else
        JSON.parse(raw_datum).deep_symbolize_keys
      end
    end

  end
end
