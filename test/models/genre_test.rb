require "test_helper"

class GenreTest < ActiveSupport::TestCase
  def setup
    @genre = Genre.new(name: "Rock")
  end

  test "género válido com todos atributos obrigatórios" do
    assert @genre.valid?, "O gênero deveria ser válido com o nome presente"
  end

  test "inválido sem nome" do
    @genre.name = ""
    assert_not @genre.valid?, "Não pode ser válido sem nome"
    assert_includes @genre.errors[:name], "can't be blank"
  end
end
