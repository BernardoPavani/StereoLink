require "test_helper"

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: "Test User", email: "test@example.com", password: "password", role: "artist")
  end

  test "valid user" do
    assert @user.valid?
  end

  test "invalid without name" do
    @user.name = ""
    assert_not @user.valid?
    assert_includes @user.errors[:name], "can't be blank"
  end

  test "invalid without email" do
    @user.email = ""
    assert_not @user.valid?
    assert_includes @user.errors[:email], "can't be blank"
  end

  test "invalid without role" do
    @user.role = ""
    assert_not @user.valid?
    assert_includes @user.errors[:role], "can't be blank"
  end

  test "invalid if email not unique" do
    @user.save!
    other_user = User.new(name: "Another User", email: "test@example.com", password: "password", role: "artist")
    assert_not other_user.valid?
    assert_includes other_user.errors[:email], "has already been taken"
  end

  test "has many albums with dependent destroy" do
    @user.save!
    album = @user.albums.create!(title: "Test Album", description: "Description")
    assert_difference("Album.count", -1) do
      @user.destroy
    end
    assert_raises(ActiveRecord::RecordNotFound) { album.reload }
  end
end
