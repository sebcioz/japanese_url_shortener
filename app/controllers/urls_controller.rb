class UrlsController < ApplicationController

  before_filter :find_urls

  def new
    @url = Url.new
  end

  def create
    @url = Url.new(params[:url])
    @url.user_id = user_id
    @url.create_shortcut

    if @url.save
      flash[:success] = 'Url shortened.'
      redirect_to root_path
    else
      flash[:alert] = 'Given url is invalid.'
      render :action => 'new'
    end
  end

  def visit
    agent = Agent.new(request.env['HTTP_USER_AGENT'] || "")

    url = Url.where(:shortcut => params[:shortcut]).first
    url.click!(agent)

    redirect_to url.target
  end

  private

  def find_urls
    @urls = Url.where(:user_id => user_id).all
  end

end