class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def show
      @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
    unless current_user == @user
      flash[:notice] =  "Back off, not your id!"
      redirect_to products_path
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to products_url, notice: "Signed up!"
    else
      render "new"
    end
  end

  def update
    @user = User.find(params[:id])

      if @user.update_attributes(user_params)
        redirect_to user_path(@user)
      else
        render :edit
      end
  end

  private
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :name)
  end

  def authenticate
    @user = User.find(params[:id])
    unless current_user == @user
      flash[:notice] =  "Back off, not your id!"
      redirect_to products_path
    end
  end
end
