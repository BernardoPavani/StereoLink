require "test_helper"

class TrackTest < ActiveSupport::TestCase
  def setup
    @user = User.create!(name: "Test User", email: "test@example.com", password: "password", role: "artist")
    @album = Album.create!(title: "Test Album", description: "Description", user: @user)
    @track = Track.new(name: "Test Track", link: "http://example.com", album: @album)
  end

  test "valid track" do
    assert @track.valid?
  end

  test "invalid without name" do
    @track.name = ""
    assert_not @track.valid?
    assert_includes @track.errors[:name], "can't be blank"
  end

  test "invalid without link" do
    @track.link = ""
    assert_not @track.valid?
    assert_includes @track.errors[:link], "can't be blank"
  end

  test "invalid without album" do
    @track.album = nil
    assert_not @track.valid?
    assert_includes @track.errors[:album], "must exist"
  end
end
