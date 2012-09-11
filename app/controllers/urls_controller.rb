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
      flash[:success] = 'Url shortened.'
    else
      flash[:alert] = 'Given url is invalid.'
      render :action => 'new'
    end
  end

  def visit
    url = Url.where(:shortcut => params[:shortcut]).first
    agent = Agent.new(request.env['HTTP_USER_AGENT'] || "")
    url.click!(agent)
    redirect_to url.target
  end

  private

  def find_urls
    @urls = Url.all
  end

end
