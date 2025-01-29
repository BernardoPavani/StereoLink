require "test_helper"

class AlbumTest < ActiveSupport::TestCase
  def setup
    @user = User.create!(
      name: "User Test",
      email: "user@test.com",
      password: "password",
      role: "artist"
    )

    @album = Album.new(
      title: "Álbum de Teste",
      description: "Descrição do álbum de teste",
      user: @user
    )
  end

  test "álbum válido quando possui todos os atributos obrigatórios" do
    assert @album.valid?, "O álbum deveria ser válido com todos os atributos obrigatórios"
  end

  test "álbum inválido sem título" do
    @album.title = ""
    assert_not @album.valid?, "O álbum não pode ser válido sem título"
    assert_includes @album.errors[:title], "can't be blank"
  end

  test "álbum inválido sem descrição" do
    @album.description = ""
    assert_not @album.valid?, "O álbum não pode ser válido sem descrição"
    assert_includes @album.errors[:description], "can't be blank"
  end

  test "álbum inválido sem usuário associado" do
    @album.user = nil
    assert_not @album.valid?, "O álbum não pode ser válido sem pertencer a um usuário"
    assert_includes @album.errors[:user], "must exist"
  end

  test "associação com tracks e dependent destroy" do
    @album.save!

    track = @album.tracks.create!(name: "Track 1", link: "http://example.com/track1.mp3")
    assert_equal 1, @album.tracks.count

    assert_difference("Track.count", -1) do
      @album.destroy
    end
    assert_raises(ActiveRecord::RecordNotFound) { track.reload }
  end

  test "associação com genres via album_genres e dependent destroy" do
    genre = Genre.create!(name: "Rock")
    @album.save!
    
    @album.genres << genre
    assert_equal 1, @album.genres.count

    assert_difference("AlbumGenre.count", -1) do
      @album.destroy
    end

    assert_not_nil genre.reload
  end
end
