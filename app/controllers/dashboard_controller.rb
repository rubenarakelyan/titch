class DashboardController < ApplicationController
  include Authenticated

  skip_before_action :authenticate

  def index
    return unless logged_in?

    @top_links = Link.order(created_at: :desc).limit(10)
    @top_views = View.order(created_at: :desc).limit(10)
  end
end
