module Authenticated
  extend ActiveSupport::Concern

  included do
    before_action :authenticate
  end

  def authenticate
    redirect_to root_path if session[:userinfo].blank?
  end

  def logged_in?
    session[:userinfo].present?
  end
end
