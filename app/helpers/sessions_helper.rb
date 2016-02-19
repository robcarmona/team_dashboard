module SessionsHelper

  def logged_in?
    current_user.present?
  end

  def authorize
   redirect_to login_path unless logged_in?
  end

  def current_user
    User.find_by(id: session[:user_id]) if session[:user_id].present?
  end

end
