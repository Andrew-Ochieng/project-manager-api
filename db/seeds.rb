puts "🌱 Seeding users ..."

# Make 10 users
10.times do
  User.create(
      username: Faker::Name.name,
      email: Faker::Internet.email(name: username)
      password: Faker::Internet.password(min_length: 8)
  )
end

  # Make 50 projects
50.times do
  Project.create(
      name: Faker::Team.state,
      topic: Faker::Space.galaxy,
      details: Faker::Lorem.paragraphs(number: 1, supplemental: true)
  )
end

puts "✅ Done seeding!"
