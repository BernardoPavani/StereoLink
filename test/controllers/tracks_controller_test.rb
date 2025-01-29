require "test_helper"

class TracksControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = User.create(
      name: "Test User",
      email: "testuser@example.com",
      password: "password",
      role: "listener"
    )

    @album = Album.create(
      title: "Album de Teste",
      description: "Descrição do álbum de teste",
      user: @user
    )

    @track = Track.create(
      name: "Track Inicial",
      link: "http://example.com/track.mp3",
      album: @album
    )
  end

  # Simula login do @user para passar pelo authenticate!
  def sign_in_user
    post sign_in_post_path, params: {
      user: {
        email: @user.email,
        password: "password"
      }
    }
    assert_equal @user.id, session[:user_id], "Falha no login de teste."
  end

  test "deve redirecionar para sign_in se não estiver logado (GET index)" do
    get tracks_path
    assert_redirected_to sign_in_path
  end

  test "deve exibir index se estiver logado (GET index)" do
    sign_in_user
    get tracks_path
    assert_response :success
    assert_select "td", text: @track.name
  end


  test "deve redirecionar para sign_in se não estiver logado (GET new)" do
    get new_track_path(album: @album.id)
    assert_redirected_to sign_in_path
  end

  test "deve exibir formulário para nova track se estiver logado (GET new)" do
    sign_in_user
    get new_track_path(album: @album.id)
    assert_response :success
    assert_select "form"
  end

  test "deve redirecionar para sign_in se não estiver logado (POST create)" do
    post tracks_path, params: {
      track: {
        name: "Nova Faixa",
        link: "http://example.com/nova.mp3",
        album_id: @album.id
      }
    }
    assert_redirected_to sign_in_path
  end

  test "deve criar uma nova track se estiver logado (POST create)" do
    sign_in_user

    assert_difference "Track.count", 1 do
      post tracks_path, params: {
        track: {
          name: "Nova Faixa",
          link: "http://example.com/nova.mp3",
          album_id: @album.id
        }
      }
    end

    assert_redirected_to album_path(id: @album.id)
    follow_redirect!
    assert_match "Faixa criada com sucesso", flash[:notice]
  end

  test "deve falhar ao criar track com parâmetros inválidos (POST create)" do
    sign_in_user

    assert_no_difference "Track.count" do
      post tracks_path, params: {
        track: {
          name: "",
          link: "http://example.com/nova.mp3",
          album_id: @album.id
        }
      }
    end

    assert_response :unprocessable_entity
    assert_match "Erro ao criar a faixa", flash[:notice]
  end

  test "deve redirecionar para sign_in se não estiver logado (GET edit)" do
    get edit_track_path(@track, album: @album.id)
    assert_redirected_to sign_in_path
  end

  test "deve exibir formulário de edição se estiver logado (GET edit)" do
    sign_in_user
    get edit_track_path(@track, album: @album.id)
    assert_response :success
    assert_select "form"
  end

  test "deve redirecionar para sign_in se não estiver logado (PATCH/PUT update)" do
    patch track_path(@track), params: {
      track: {
        name: "Track Atualizada",
        link: "http://example.com/atualizada.mp3",
        album_id: @album.id
      }
    }
    assert_redirected_to sign_in_path
  end

  test "deve atualizar track se estiver logado (PATCH/PUT update)" do
    sign_in_user
    patch track_path(@track), params: {
      track: {
        name: "Track Atualizada",
        link: "http://example.com/atualizada.mp3",
        album_id: @album.id
      }
    }

    assert_redirected_to album_path(@album)
    follow_redirect!
    assert_match "Faixa atualizada com sucesso", flash[:notice]

    @track.reload
    assert_equal "Track Atualizada", @track.name
    assert_equal "http://example.com/atualizada.mp3", @track.link
  end

  test "deve falhar ao atualizar track com parâmetros inválidos (PATCH/PUT update)" do
    sign_in_user
    patch track_path(@track), params: {
      track: {
        name: nil, # inválido
        link: "http://example.com/atualizada.mp3",
        album_id: @album.id
      }
    }

    assert_response :unprocessable_entity
    assert_match "Erro ao atualizar a faixa", flash[:notice]

    @track.reload
    refute_equal "", @track.name
  end

  test "deve redirecionar para sign_in se não estiver logado (DELETE destroy)" do
    delete track_path(@track, album: @album.id)
    assert_redirected_to sign_in_path
  end

  test "deve deletar uma track se estiver logado (DELETE destroy)" do
    sign_in_user

    assert_difference "Track.count", -1 do
      delete track_path(@track, album: @album.id)
    end

    assert_redirected_to album_path(@album)
    follow_redirect!
    assert_match "Faixa deletada com sucesso", flash[:notice]
  end
end
