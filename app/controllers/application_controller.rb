class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :authenticate_user!

  def authenticate_admin
    unless current_user.admin?
      flash[:error] = "Need administrator rights"
      redirect_to root_path
    end
  end

end
