class UsersController < ApplicationController
  def show
    #find_by method automatically does the sanity check on user input
    #to prevent SQL injection
    #@user = User.find(params[:id])
    @user = User.find_by_id(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to RefuMe!"
      redirect_to @user
    else
      render 'new'
    end
  end

  private
    #handle mass assignment
    def user_params
      params.require(:user).permit(:name, :email, :age, :country, :language,
                                   :zipcode, :goals, :password, :password_confirmation)
    end
end
