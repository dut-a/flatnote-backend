
puts "Begin: Destroying Users"
User.where.not(username: "dut").destroy_all
puts "End: Destroying Users"

puts "Begin: Destroying Notes"
Note.destroy_all
puts "End: Destroying Notes"

puts "Begin: Adding Users"
5.times do
  User.create(
    username: Faker::Name.first_name, password: 'pword', avatar: Faker::Fillmurray.image, bio: Faker::TvShows::Friends.quote
  )
end
puts "End: Adding Users"

puts "Begin: Adding Notes"
20.times do
  Note.create(
    title: Faker::Lorem.sentence,
    notes: Faker::Lorem.paragraphs.join(" "),
    tags: "JS, Java, Android, React, Redux, CSS",
    user_id: User.all.sample.id
  )
end
puts "End: Adding Notes"

