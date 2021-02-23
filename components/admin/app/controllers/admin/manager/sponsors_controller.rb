require_dependency "admin/application_controller"

module Admin
  class Manager::SponsorsController < Admin::Manager::ApplicationController
    # before_action :set_manager_sponsor, only: [:show, :edit, :update, :destroy]

    # GET /manager/sponsors
    def index
      # @manager_sponsors = Manager::Sponsor.all
    end

    # GET /manager/sponsors/1
    def show
    end

    # GET /manager/sponsors/new
    def new
      @manager_sponsor = Manager::Sponsor.new
    end

    # GET /manager/sponsors/1/edit
    def edit
    end

    # POST /manager/sponsors
    def create
      @manager_sponsor = Manager::Sponsor.new(manager_sponsor_params)

      if @manager_sponsor.save
        redirect_to @manager_sponsor, notice: 'Sponsor was successfully created.'
      else
        render :new
      end
    end

    # PATCH/PUT /manager/sponsors/1
    def update
      if @manager_sponsor.update(manager_sponsor_params)
        redirect_to @manager_sponsor, notice: 'Sponsor was successfully updated.'
      else
        render :edit
      end
    end

    # DELETE /manager/sponsors/1
    def destroy
      @manager_sponsor.destroy
      redirect_to manager_sponsors_url, notice: 'Sponsor was successfully destroyed.'
    end

    private

      # Only allow a list of trusted parameters through.
      def manager_sponsor_params
        params.fetch(:manager_sponsor, {})
      end
  end
end
