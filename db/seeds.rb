# frozen_string_literal: true

# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

5.times do
  User.create(
    name: Faker::Name.name,
    email: Faker::Internet.email
  )
end

2.times do
  Category.create(name: Faker::Commerce.department)
end

IMAGES = %w[test_image_1.png test_image_2.jpg].freeze

20.times do
  bulletin = Bulletin.create(
    title: Faker::Lorem.sentence(word_count: 3, supplemental: false, random_words_to_add: 0).truncate(50),
    description: Faker::Lorem.paragraph(sentence_count: 5).truncate(1000),
    category: Category.order('RANDOM()').limit(1).last,
    user: User.order('RANDOM()').limit(1).last
  )
  image_file = IMAGES.sample
  file_path = Rails.root.join("test/fixtures/files/#{image_file}")
  bulletin.image.attach(io: File.open(file_path), filename: image_file)
  bulletin.save
end
