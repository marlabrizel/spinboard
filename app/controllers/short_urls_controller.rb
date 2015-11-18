class ShortUrlsController < ApplicationController
  def show
    destination = Link.find_by(slug: params[:slug]).valid_url
    redirect_to destination
  end
end
