require_dependency "admin/application_controller"
# TODO: not begin to edit.
module Admin
  class Manager::AdminsController < Admin::Manager::ApplicationController
    before_action :set_manager_admin, only: [:show, :edit, :update, :destroy]

    # GET /manager/admins
    def index
      @manager_admins = Manager::Admin.all
    end

    # GET /manager/admins/1
    def show
    end

    # GET /manager/admins/new
    def new
      @manager_admin = Manager::Admin.new
    end

    # GET /manager/admins/1/edit
    def edit
    end

    # POST /manager/admins
    def create
      @manager_admin = Manager::Admin.new(manager_admin_params)

      if @manager_admin.save
        redirect_to @manager_admin, notice: 'Admin was successfully created.'
      else
        render :new
      end
    end

    # PATCH/PUT /manager/admins/1
    def update
      if @manager_admin.update(manager_admin_params)
        redirect_to @manager_admin, notice: 'Admin was successfully updated.'
      else
        render :edit
      end
    end

    # DELETE /manager/admins/1
    def destroy
      @manager_admin.destroy
      redirect_to manager_admins_url, notice: 'Admin was successfully destroyed.'
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_manager_admin
        @manager_admin = Manager::Admin.find(params[:id])
      end

      # Only allow a list of trusted parameters through.
      def manager_admin_params
        params.fetch(:manager_admin, {})
      end
  end
end
