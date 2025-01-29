# Rake task for creating genres

namespace :genres do
  desc 'Create genres'
  task create: :environment do
    genres = %w[Eletronica Jazz Metal Pop Rock MPB]
    genres.each do |genre|
      Genre.find_or_create_by(name: genre)
    end
  end
end