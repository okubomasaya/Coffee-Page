class RelationshipsController < ApplicationController
  
  
  # フォローする
  def create
      @user = User.find(params[:followed_id])
      current_user.follow(@user)
  end

  # アンフォローする
  def destroy
      @user = User.find(params[:id])
      current_user.unfollow(@user)
  end
  
end
