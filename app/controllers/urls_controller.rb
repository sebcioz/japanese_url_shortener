class UrlsController < ApplicationController

  def new
    @urls = Url.all
    @url = Url.new
  end

  def create
    @url = Url.new(params[:url])
    @url.generate_shortcut(Time.now.to_i)
    
    if @url.save
      redirect_to root_path
    end
  end

  def visit
    url = Url.where(:shortcut => params[:shortcut]).first
    redirect_to url.target
  end

end
