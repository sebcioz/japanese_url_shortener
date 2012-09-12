class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :user_id

  private

  def user_id
    session[:user_id] ||= "#{SecureRandom.urlsafe_base64}-#{DateTime.now.to_i}"
  end
end
