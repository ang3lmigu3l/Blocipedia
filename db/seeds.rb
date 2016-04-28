require 'faker'

5.times do
  User.create!(
  :username => Faker::Internet.user_name,
  :email => Faker::Internet.email,
  :password => '12341234',
  :password_confirmation => '12341234'
  )
end
 users = User.all

100.times do
  Wiki.create!(
  :user => users.sample,
  :title => Faker::Lorem.sentence,
  :body => Faker::Lorem.paragraph(4),
  :private => false
  )
end

admin = User.create!(
  :username => 'Ang3lmigu3l',
  :email => 'quintana.mige@gmail.com',
  :password => '12341234',
  :password_confirmation => '12341234',
  :role => 'admin'
  )

puts "#{User.count} users created!"
puts "#{Wiki.count} wikis created!"
