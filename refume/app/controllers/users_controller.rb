class UsersController < ApplicationController
  # To update personal information, the user must already log in;
  # and that user can only modify his/her own information.
  before_action :logged_in_user, only: [:edit, :update]
  before_action :correct_user,   only: [:edit, :update, :show]

  def show
    #find_by method automatically does the sanity check on user input
    #to prevent SQL injection
    #@user = User.find(params[:id])
    @user = User.find_by_id(params[:id])
    #get all the matched mentors/mentees for this user
    @matches = nil
    if @user.role == "Mentee"
      @matches = Match.where(mentee_id: @user.id)
    elsif @user.role == "Mentor"
      @matches = Match.where(mentor_id: @user.id)
    end

    #retrieve all the mentors/mentees names
    @mentors = []
    @mentees = []
    @matches = [] if @meatches.nil?
    @matches.each do |match|
      if @user.role == "Mentor"
        user = User.find_by_id(match.mentee_id)
        @mentees << user.name
      else
        user = User.find_by_id(match.mentor_id)
        @mentors << user.name
      end
    end

  end

  def new
    if logged_in?
      flash[:danger] = "Please log out before signing up."
      redirect_to(root_url)
    else
      @user = User.new
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      # send activation link to user email
      UserMailer.account_activation(@user).deliver_now
      flash[:info] = "Please check your email to activate your account."
      redirect_to root_url
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
    @matches = Match.where(mentee_id: @user.id)
  end

  def mentees
    @matches = Match.where(mentor_id: @user.id)
  end

  private
    #handle mass assignment
    def user_params
      params.require(:user).permit(:name, :email, :age, :country, :language,
                                   :role, :zipcode, :goals, :bio, :password, :password_confirmation)
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
