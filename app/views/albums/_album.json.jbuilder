json.extract! album, :id, :title, :description, :genre_id, :created_at, :updated_at
json.url album_url(album, format: :json)
