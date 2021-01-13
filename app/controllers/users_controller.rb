class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    helpers.get_rna_asso_by_rna(@user.rna)
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_url, notice: "Thank you for signing up!"
    else
      render "new"
    end
  end

  private 

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :rna)
  end
end
