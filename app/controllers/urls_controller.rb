class UrlsController < ApplicationController

  before_filter :find_urls

  def new
    @url = Url.new
  end

  def create
    @url = Url.new(params[:url])
    @url.generate_shortcut

    if @url.save
      redirect_to root_path
    else
      flash[:error] = 'Given url is invalid.'
      render :action => 'new'
    end
  end

  def visit
    url = Url.where(:shortcut => params[:shortcut]).first
    url.clicks.create!(:browser => request.env['HTTP_USER_AGENT'])
    redirect_to url.target
  end

  private

  def find_urls
    @urls = Url.all
  end

end
