class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  # before_action :require_user, only: [:edit, :update]
  # before_action :require_same_user, only: [:edit, :update, :destroy]



  def show
    @folders = @user.folders.all
  end

  def new
    @user = User.new
  end

  def index
    @users = User.all
  end

  def create
    debugger
    @user = User.new(user_params)
    debugger
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "Welcome to the FMS #{@user.name}, you have successfully signed up"
      redirect_to user_path(@user)
    else
      puts "Parameters received: #{params.inspect}" # Add this line to inspect parameters
      render 'new', status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:notice] = "Your account information was successfully updated"
      redirect_to user_path(@user)
    else
      render 'new', status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy
    session[:user_id] = nil if @user == current_user
    flash[:notice] = "Account and all associated folders successfully deleted"
    redirect_to folders_path
  end





  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :user_type)
  end

  def set_user
    @user = User.find(params[:id])
  end

end
