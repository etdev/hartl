class UsersController < ApplicationController
  
  def show
  	@user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def new
  	@user = User.new
  end

  def create
  	@user = User.new(user_params)
  	if @user.save
  		#Handle a successful save
      sign_in @user
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
