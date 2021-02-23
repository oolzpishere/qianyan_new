module Admin
  class Manager::ApplicationController < ::Admin::ApplicationController

    before_action :authenticate_admin!

    # before_action :store_location, :only => [:edit]


    private

      def store_location
        session[:return_to] = request.referer if request.get? and controller_name != "user_sessions" and controller_name != "sessions"
      end

      def redirect_back_or_default(default, *args)
        redirect_to(session.delete(:return_to) || default, *args)
      end

  end
end
