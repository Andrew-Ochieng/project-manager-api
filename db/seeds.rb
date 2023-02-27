puts "🌱 Seeding spices..."

# Make 10 users
10.times do
    User.create(
        name: Faker::Name.name
    )
  end

  # Make 10 users
10.times do
    Project.create(
        name: Faker::Team.state,
        topic: Faker::Space.galaxy,
        description: Faker::Lorem.paragraphs(number: 1, supplemental: true)
    )
  end

puts "✅ Done seeding!"
