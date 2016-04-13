class UsersController < ApplicationController
before_filter :user_authorization

  def show
    @user = User.find(params[:id])
  end

private
  def user_authorization
    if current_user.id != params[:id].to_i
    flash[:notice] = "You are not Authorized to do that."
    redirect_to root_path
  end
end
end
