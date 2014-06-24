class UsersController < ApplicationController
  
  #Check if signed in on these pages (signed_in_user is a method defined in this file)
  before_action :signed_in_user, only: [:index, :edit, :update, :destroy, :following, :followers]
  #Check if the user is correct, when on the edit page (i.e. you can't edit someone else's info)
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user,  only: :destroy 

  def show
  	@user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
  end

  def index
    @users = User.paginate(page: params[:page])
  end

  def edit
    #@user = User.find(params[:id]) #You no longer need this because the correct_user
    #before filter defines @user.
  end

  def update
    #@user = User.find(params[:id]) #no longer needed since we added the before filter
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted."
    redirect_to users_url
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

  def following
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.followed_users.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end

  #Auxiliary method called user_params that returns an appropriate init. hash for 
  #the User model.  You don't test this.
  private
    def user_params
    	params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    #Before filters
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end










