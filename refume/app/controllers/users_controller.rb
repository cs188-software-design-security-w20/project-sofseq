class UsersController < ApplicationController
  def show
    #find_by method automatically does the sanity check on user input
    #to prevent SQL injection
    #@user = User.find_by(params[:id])
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to @user
    else
      render 'new'
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
                                   :zipcode, :goals, :password, :password_confirmation)
    end
end
