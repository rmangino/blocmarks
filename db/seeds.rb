# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'faker'

###############################################################################

# Clear out existing data

User.destroy_all

###############################################################################

# Helpers

def create_user(name, email, password)
  user = User.new(name: name, email: email, password: password)
  user.save!
end

###############################################################################

# Create Users

user1 = create_user('User1', 'user1@example.com', "helloworld")
user2 = create_user('User2', 'user2@example.com', "helloworld")
reed  = create_user('Reed', 'reed@themanginos.com', "helloworld")

###############################################################################

###############################################################################

# Create Topics and Bookmarks for each user

# Random, valid urls
VALID_URLS = ["https://github.com/felipeelias/embedly-ruby",
              "http://rocketfuel.com/webinars/success/14",
              "https://www.railstutorial.org/book/modeling_users",
              "https://github.com/mperham/sidekiq/wiki/Getting-Started",
              "https://training.docker.com/introduction-to-docker",
              "http://embed.ly/docs/api/embed/arguments"]

User.all.each do |user|
  3.times do
    topic = Topic.create!(user: user, title: "topic-#{Faker::Lorem.word}")
    3.times do
      Bookmark.create!(topic: topic, url: VALID_URLS.sample)
    end
  end

  # Create a default topic and bookmark for this user
  topic = Topic.default_topic_for_user(user)
  bookmark = Bookmark.create!(topic: topic, url: VALID_URLS.sample)
  topic.bookmarks << bookmark
  topic.save!
end


# Report results

puts "Seed Finished"
puts "#{User.count} users created"
puts "#{Topic.count} topics created"
puts "#{Bookmark.count} bookmarks created"