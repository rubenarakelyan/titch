module ApplicationHelper
  include Pagy::Frontend

  def logged_in?
    session[:userinfo].present?
  end
end
