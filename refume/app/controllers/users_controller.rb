class UsersController < ApplicationController
  # To update personal information, the user must already log in;
  # and that user can only modify his/her own information.
  before_action :logged_in_user, only: [:edit, :update]
  before_action :correct_user,   only: [:edit, :update]

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
      #log in user automatically once they finish signing up
      log_in @user
      flash[:success] = "Welcome to RefuMe!"
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
    @user = User.find_by_id(params[:id])
  end

  def update
    @user = User.find_by_id(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def mentors
    @matches = Match.where(mentee_id: @author.id)
  end

  def mentees
    @matches = Match.where(mentor_id: @author.id)
  end

  private
    #handle mass assignment
    def user_params
      params.require(:user).permit(:name, :email, :age, :country, :language,
                                   :zipcode, :goals, :bio, :password, :password_confirmation)
    end

    # Before filters
    # Confirms a logged-in user.
    def logged_in_user
      unless logged_in?
        #We store the location where the users want to go
        #and then ask them to log in, once they log in, we will
        #redirect them to that location.
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end

    # Confirms the correct user.
    def correct_user
      @user = User.find_by_id(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end
end
