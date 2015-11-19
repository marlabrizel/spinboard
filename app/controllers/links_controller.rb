class LinksController < ApplicationController
  before_action :find_link, only: [:edit, :update, :mark_read, :mark_unread]

  def index
    @link = Link.new
    @links = current_user.links if current_user
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

  def mark_read
    @link.update_attributes(read_status: true)
    redirect_to links_path
  end

  def mark_unread
    @link.update_attributes(read_status: false)
    redirect_to links_path
  end

  private

  def link_params
    params.require(:link).permit(:title, :valid_url)
  end

  def find_link
    @link = Link.find(params[:id])
  end
end
