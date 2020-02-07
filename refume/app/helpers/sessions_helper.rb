module SessionsHelper
  # Logs in the given user.
  # Because temporary cookies created using the session method are automatically encrypted,
  # this code is secure; there is no way for an attacker to use the session information to log in as the user.
  # Note: This applies only to temporary sessions initiated with the session method, though,
  # and is not the case for persistent sessions created using the cookies method.
  def log_in(user)
    session[:user_id] = user.id
  end

  # Returns the current logged-in user (if any).
  def current_user
    if session[:user_id]
      @current_user ||= User.find_by(id: session[:user_id])
    end
  end

  # Returns true if the user is logged in, false otherwise.
  def logged_in?
    !current_user.nil?
  end
end
