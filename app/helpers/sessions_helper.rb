module SessionsHelper

  def sign_in(user)
    remember_token = User.new_remember_token
    cookies[:remember_token] = { value: remember_token,
                                 expires: 30.days.from_now.utc }
    user.update_attribute(:remember_token, User.encrypt(remember_token))
    self.current_user = user
  end

  def sign_out
    self.current_user = nil
    cookies.delete(:remember_token)
  end

  def current_user=(user)
    @current_user = user
  end

  def current_user
    remember_token = User.encrypt(cookies[:remember_token])
    # Follow line means 
    # If @current_user is nil?
    # then @current_user = User.find_by...
    # else return @current_user
    @current_user ||= User.find_by(remember_token: remember_token)
  end

  def signed_in?
    !current_user.nil?
  end
end
