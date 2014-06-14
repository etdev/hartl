class UsersController < ApplicationController
  
  def show
  	@user = User.find(params[:id])
  end

  def new
  	@user = User.new
  end

  def create
  	@user = User.new(user_params) #Not the final implementation
  	if @user.save
  		#Handle a successful save
  		flash[:success] = "Welcome to the Sample App!"
  		redirect_to @user
  	else
  		render 'new'
  	end
  end

  #Auxiliary method called user_params that returns an appropriate init. hash for 
  #the User model.  You don't test this.
  private
  def user_params
  	params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
