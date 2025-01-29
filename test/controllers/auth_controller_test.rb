# test/controllers/auth_controller_test.rb
require "test_helper"

class AuthControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = User.create(
      name: "Test User",
      email: "testuser@example.com",
      password: "password",
      role: "listener"
    )
  end

  test "deve exibir a tela de sign_in (GET sign_in)" do
    get sign_in_path
    assert_response :success 
    assert_select "form"
  end

  test "deve efetuar login (POST sign_in_post) com credenciais válidas" do
    post sign_in_post_path, params: {
      user: {
        email: @user.email,
        password: "password"
      }
    }
    assert_redirected_to root_path
    assert_equal @user.id, session[:user_id], "O ID do usuário deveria estar na sessão."
    follow_redirect!
    assert_match "Login realizado com sucesso", flash[:notice]
  end

  test "não deve efetuar login (POST sign_in_post) com credenciais inválidas" do
    post sign_in_post_path, params: {
      user: {
        email: @user.email,
        password: "senha_errada"
      }
    }
    assert_redirected_to sign_in_path
    assert_nil session[:user_id], "A sessão não deveria ter um user_id quando as credenciais são inválidas."
    follow_redirect!
    assert_match "Email ou senha inválidos", flash[:notice]
  end

  test "deve exibir a tela de sign_up (GET sign_up)" do
    get sign_up_path
    assert_response :success
    assert_select "form"
  end

  test "deve realizar cadastro (POST sign_up_post) com dados válidos" do
    assert_difference("User.count", 1) do
      post sign_up_post_path, params: {
        user: {
          name: "Novo Usuário",
          email: "newuser@example.com",
          password: "password",
          password_confirmation: "password",
          role: "listener"
        }
      }
    end

    assert_equal User.last.id, session[:user_id]
    assert_redirected_to root_path
    follow_redirect!
    assert_match "Cadastro realizado com sucesso", flash[:notice]
  end

  test "não deve realizar cadastro (POST sign_up_post) se as senhas não conferem" do
    assert_no_difference("User.count") do
      post sign_up_post_path, params: {
        user: {
          name: "Usuário Inválido",
          email: "failuser@example.com",
          password: "password",
          password_confirmation: "diferente"
        }
      }
    end
  
    assert_redirected_to sign_up_path
    follow_redirect!
    assert_match "Senhas não conferem", flash[:notice]
  end

  test "deve fazer logout (GET sign_out)" do
    post sign_in_post_path, params: {
      user: {
        email: @user.email,
        password: "password"
      }
    }
    assert_equal @user.id, session[:user_id], "Precisamos estar logados antes de deslogar."

    delete sign_out_path
    assert_redirected_to sign_in_path
    follow_redirect!
    assert_nil session[:user_id], "A sessão deve estar limpa após sign_out."
    assert_match "Deslogado com sucesso", flash[:notice]
  end
end
