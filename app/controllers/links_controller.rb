class LinksController < ApplicationController
  def index
    @link = Link.new
    @links = Link.all
  end

  def create
    @link = Link.new(link_params)
    if @link.save
      redirect_to links_path
    else
      flash[:danger] = "Please enter a valid URL"
      redirect_to links_path
    end
  end

  private

  def link_params
    params.require(:link).permit(:title, :valid_url)
  end
end
