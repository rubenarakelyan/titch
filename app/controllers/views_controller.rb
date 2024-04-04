class ViewsController < ApplicationController
  include Authenticated

  def index
    @pagy, @views = pagy(View.order(created_at: :desc))
  end
end
