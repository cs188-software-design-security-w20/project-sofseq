class AccountActivationsController < ApplicationController
  # action to activate users account
  def edit
    user = User.find_by(email: params[:email])
    # check if users exist, if users are already activated
    # and if the token matches with the activcation digest
    if user && !user.activated? && user.authenticated?(:activation, params[:id])
      # update users activation attribute
      user.update_attribute(:activated,    true)
      user.update_attribute(:activated_at, Time.zone.now)
      log_in user
      flash[:success] = "Account activated!"
      redirect_to user
    else
      flash[:danger] = "Invalid activation link"
      redirect_to root_url
    end
  end
end
