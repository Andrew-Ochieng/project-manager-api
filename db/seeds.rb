puts "🌱 Seeding users ..."

# Make 10 users
user = User.create(
  username: "user",
  email: "user@user.com",
  password: "password"
)

# Make 50 projects
5.times do
  Project.create(
    name: Faker::Team.state,
    topic: Faker::Space.galaxy,
    details: Faker::Lorem.paragraph,
    user_id: user.id
  )
end

puts "✅ Done seeding!"
