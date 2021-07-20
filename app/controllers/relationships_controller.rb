class RelationshipsController < ApplicationController
  
  # フォローする
  def follow
    current_user.follow(params[:id])
    redirect_to users_path
  end

  # アンフォローする
  def unfollow
    current_user.unfollow(params[:id])
    redirect_to users_path
  end
  
end
