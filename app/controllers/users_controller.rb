class UsersController < ApplicationController

  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update]

  def show
    @user = User.find(params[:id])
    @articles = @user.articles
  end

  def index
    @users = User.all
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "更新しました！"
    else
      render "edit"
    end
  end
  
  # def followings
		# user = User.find(params[:user_id])
		# @users = user.followings
  # end


  # def followers
		# user = User.find(params[:user_id])
		# @users = user.followers
  # end

  private

  def user_params
    params.require(:user).permit(:name, :profile, :profile_image)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end

end
