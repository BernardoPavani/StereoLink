class AuthController < ApplicationController
  def sign_in
    @user = User.new
  end

  def sign_in_post
    @user = User.find_by(email: user_params[:email])

    if @user && @user.authenticate(user_params[:password])
      session[:user_id] = @user.id
      redirect_to root_path, notice: 'Login realizado com sucesso'
    else
      redirect_to sign_in_path, notice: 'Email ou senha inválidos'
    end
  end

  def sign_up
    @user = User.new
  end

  def sign_up_post
    if user_params[:password] != user_params[:password_confirmation]
      redirect_to sign_up_path, notice: 'Senhas não conferem'
      return
    end
  
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path, notice: 'Cadastro realizado com sucesso'
    else
      render :sign_up, notice: 'Cadastro não realizado'
    end
  end

  def sign_out
    session[:user_id] = nil
    redirect_to sign_in_path, notice: 'Deslogado com sucesso'
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :role)
  end
end
