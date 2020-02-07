class SessionsController < ApplicationController
  def new
  end

  def create
    # input is in this format { session: { password: "foobar", email: "user@example.com" } }
    # that's why we need nested hash
    user = User.find_by(email: params[:session][:email].downcase)
    #check if user exists and is valid
    if user && user.authenticate(params[:session][:password])
      # Log the user in and redirect to the user's show page.
      log_in user
      redirect_to user
    else
      # Create an error message.
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
  end
end
