class LinksController < ApplicationController
  include Authenticated

  def index
    @pagy, @links = pagy(Link.order(created_at: :desc))
  end

  def show
    @link = Link.find(params[:shortcode])
  end

  def new
    @link = Link.new
  end

  def edit
    @link = Link.find(params[:shortcode])
  end

  def create
    @link = Link.new(link_params.merge(created_by: session[:userinfo]["name"]))

    if @link.save
      FetchOpenGraphAttributesJob.perform_later(@link.id)
      redirect_to link_path(@link), notice: "#{helpers.full_short_url(@link)} successfully created"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @link = Link.find(params[:shortcode])

    if @link.update(link_update_params)
      redirect_to link_path(@link), notice: "#{helpers.full_short_url(@link)} successfully updated"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def link_params
    params.require(:link).permit(:url)
  end

  def link_update_params
    params.require(:link).permit(:title, :description, :og_image_url, :enabled)
  end
end
