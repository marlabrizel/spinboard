class Api::V1::LinksController < Api::V1::BaseController
  before_action :find_link, only: [:update]

  def update
    respond_with Link.update(params[:id], link_params)
  end

  private

  def find_link
    @link = Link.find(params[:id])
  end

  def link_params
    params.require(:link).permit(:title, :valid_url, :read_status)
  end
end
