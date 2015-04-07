module AdminController
  def self.included m
    return unless m < ActionController::Base
    m.before_action :authenticate_admin_user!
  end

  def authenticate_admin_user!
    redirect_to new_user_session_path unless current_user.try(:admin?)
  end

  class NotAuthorized < Exception; end
end
