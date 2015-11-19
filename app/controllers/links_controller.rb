class LinksController < ApplicationController
  before_action :find_link, only: [:edit, :update]

  def index
    @link = Link.new
    @links = current_user.links.order("created_at asc") if current_user
  end

  def create
    @link = current_user.links.build(link_params)
    if @link.save
      redirect_to links_path
    else
      flash[:danger] = "Please enter a valid URL"
      redirect_to links_path
    end
  end

  def edit
  end

  def update
    @link.update(link_params)
    if @link.save
      redirect_to links_path
    else
      flash[:danger] = "Please enter a valid URL"
      render :edit
    end
  end

  private

  def link_params
    params.require(:link).permit(:title, :valid_url)
  end

  def find_link
    @link = Link.find(params[:id])
  end
end
