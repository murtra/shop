class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception 
  before_filter :set_locale
  
  private 
  
  def set_locale
    if params[:locale] && I18n.available_locales.include?(params[:locale].to_sym)
      I18n.locale = params[:locale]
    else
      # there isn't params locale, we create one and redirect
      locale = browser_locale || I18n.default_locale
      redirect_to(root_path locale: locale)
    end
  end 
  
  def browser_locale
    if !request.headers['HTTP_ACCEPT_LANGUAGE'].blank?
      request.headers['HTTP_ACCEPT_LANGUAGE'].split(',').first.gsub(';', '-').split('-').first .split(',').first.gsub(';', '-').split('-').first
    else
      nil
    end
  end
  
  # by default, includes locale on routes
  def default_url_options(options = {})
    {locale: I18n.locale}
  end  
  
  def login_user(user)
    session[:user_id] = user.id  
  end
  
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end  
  helper_method :current_user  
  
  def authenticate_user!
		unless current_user 
		  redirect_to new_session_url, :notice => "You need to sign in to access to this page"  
		end
	end
	
	def only_not_authenticated_user!
		if current_user 
		  redirect_to root_url, :notice => "You are already logged"  
		end
	end
end
