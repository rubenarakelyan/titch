class RedirectController < ApplicationController
  before_action :load_link

  def redirect
    View.create!(shortcode: @link.shortcode)
    redirect_to @link.url, allow_other_host: true
  end

  def show; end

  private

  def load_link
    @link = Link.find(params[:shortcode])
  end
end
