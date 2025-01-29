require "test_helper"

class AlbumsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @listener = User.create!(
      name: "Listener User",
      email: "listener@example.com",
      password: "password",
      role: "listener"
    )

    @artist = User.create!(
      name: "Artist User",
      email: "artist@example.com",
      password: "password",
      role: "artist"
    )

    @album = Album.create!(
      title: "Album Teste",
      description: "Descrição",
      user: @artist
    )
  end

  def sign_in_as(user)
    post sign_in_post_path, params: {
      user: {
        email: user.email,
        password: "password"
      }
    }
    assert_equal user.id, session[:user_id], "Falha ao fazer login no teste."
  end

  test "deve redirecionar para sign_in se não estiver logado (GET index)" do
    get albums_path
    assert_redirected_to sign_in_path
  end

  test "deve redirecionar listener para tracks_path (GET index)" do
    sign_in_as(@listener)
    get albums_path
    assert_redirected_to tracks_path
  end

  test "deve exibir listagem de álbuns para usuário com role diferente de listener (GET index)" do
    sign_in_as(@artist)
    get albums_path
    assert_response :success
    assert_select "p", text: @album.title
  end

  test "deve redirecionar para sign_in se não estiver logado (GET show)" do
    get album_path(@album)
    assert_redirected_to sign_in_path
  end

  test "deve exibir Faixas se estiver logado (GET show)" do
    sign_in_as(@artist)
    get album_path(@album)
    assert_response :success
    assert_select "h2", text: "Faixas"
  end

  test "deve redirecionar para sign_in se não estiver logado (GET new)" do
    get new_album_path
    assert_redirected_to sign_in_path
  end

  test "deve exibir formulário para novo álbum se estiver logado (GET new)" do
    sign_in_as(@artist)
    get new_album_path
    assert_response :success
    assert_select "form"
  end

  test "deve redirecionar para sign_in se não estiver logado (POST create)" do
    post albums_path, params: {
      album: {
        title: "Novo Album",
        description: "Uma descrição",
        user_id: @artist.id
      }
    }
    assert_redirected_to sign_in_path
  end

  test "deve criar album se estiver logado (POST create)" do
    sign_in_as(@artist)
    assert_difference "Album.count", 1 do
      post albums_path, params: {
        album: {
          title: "Novo Álbum",
          description: "Descrição do Novo Álbum",
          user_id: @artist.id
        }
      }
    end

    assert_redirected_to album_path(Album.last)
    follow_redirect!
    assert_match "Album criado com sucesso", flash[:notice]
  end

  test "deve falhar ao criar album com parâmetros inválidos (POST create)" do
    sign_in_as(@artist)
    assert_no_difference "Album.count" do
      post albums_path, params: {
        album: {
          title: "",  # inválido
          description: "Descrição",
          user_id: @artist.id
        }
      }
    end

    assert_response :unprocessable_entity
    assert_select "form"
  end

  test "deve redirecionar para sign_in se não estiver logado (GET edit)" do
    get edit_album_path(@album)
    assert_redirected_to sign_in_path
  end

  test "deve exibir formulário de edição se estiver logado (GET edit)" do
    sign_in_as(@artist)
    get edit_album_path(@album)
    assert_response :success
    assert_select "form"
  end

  test "deve redirecionar para sign_in se não estiver logado (PATCH/PUT update)" do
    patch album_path(@album), params: {
      album: {
        title: "Alterado",
        description: "Nova desc"
      }
    }
    assert_redirected_to sign_in_path
  end

  test "deve atualizar o álbum se estiver logado (PATCH/PUT update)" do
    sign_in_as(@artist)
    patch album_path(@album), params: {
      album: {
        title: "Título Alterado",
        description: "Descrição Alterada"
      }
    }
    assert_redirected_to albums_path
    follow_redirect!
    assert_match "Album atualizado com sucesso", flash[:notice]

    @album.reload
    assert_equal "Título Alterado", @album.title
    assert_equal "Descrição Alterada", @album.description
  end

  test "deve falhar ao atualizar com parâmetros inválidos (PATCH/PUT update)" do
    sign_in_as(@artist)
    patch album_path(@album), params: {
      album: {
        title: "", # inválido
        description: "Tentativa de desc"
      }
    }
    assert_response :unprocessable_entity
    assert_select "form"

    @album.reload
    refute_equal "", @album.title
  end

  test "deve redirecionar para sign_in se não estiver logado (DELETE destroy)" do
    delete album_path(@album)
    assert_redirected_to sign_in_path
  end

  test "deve deletar álbum se estiver logado (DELETE destroy)" do
    sign_in_as(@artist)
    assert_difference "Album.count", -1 do
      delete album_path(@album)
    end

    assert_redirected_to albums_path
    follow_redirect!
    assert_match "Album deletado com sucesso", flash[:notice]
  end
end
