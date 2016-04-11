class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "Account successfully created"
      session[:user_id] = @user.id
      redirect_to root_path
    else
      render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
  end

  def update
    if @user.update(params.require(:user).permit(:email, :password, :password_confirmation))
      redirect_to @user , notice: "Your settings were successfully updated."
    else
      render 'edit'
    end
  end

  def destroy
    @user.destroy
    redirect_to root_path, notice: "Account successfully closed."
  end

  private
    def user_params
      params.require(:user).permit(:username, :email, :password, :password_confirmation, :account_level)
    end
end
