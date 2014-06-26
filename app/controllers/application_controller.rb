class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :set_locale
 
  def set_locale
    if params[:locale]
      I18n.locale = params[:locale]
      cookies[:locale] = params[:locale]
    elsif cookies[:locale]
      I18n.locale = cookies[:locale]
    end
  end

  def authenticate
    if Rails.env.production?
      authenticate_or_request_with_http_basic do |username, password|
        username == "astra" && password == "a2st5a?"
      end 
    end
  end
end
