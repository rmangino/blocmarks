class Topic < ActiveRecord::Base
  belongs_to :user
  has_many :bookmarks

  # Returns the default topic for user. If no default topic exists for user
  # a new default topic will be created.
  def self.default_topic_for_user(user)
    Topic.find_or_create_by(title: self.default_topic_name, user: user)
  end

private

  def self.default_topic_name
    "default"
  end
end
