class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @asso = helpers.get_rna_asso_by_rna(@user.rna)
    if @user.save
      if @asso
        if @user.asso_name == @asso[:name]
          @association = Association.new(name: @asso[:name], rna_id: @asso[:rna_id], official_id: @asso[:official_id], user_id: @user.id)
          @association.save
          session[:user_id] = @user.id
          redirect_to root_url, notice: "Thank you for signing up!"
        else
          @user.errors.full_messages.push("Le nom renseigné ne correspond pas au numéro RNA")
          render "new"
        end
      else
        @user.errors.full_messages.push("Le numero RNA renseigné n'est pas valide")
        render "new"
      end
    else
      @user.errors.full_messages.push("L'utilisateur n'a pas pu être enregistré, veuillez réessayer.")
      render "new"
    end
  end

  private 

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :rna, :asso_name)
  end

  def association_params
    params.require(:associtaion).permit(:name, :rna_id, :official_id, :user_id)
  end
end
