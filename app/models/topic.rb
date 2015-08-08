class Topic < ActiveRecord::Base
  belongs_to :user
  has_many :bookmarks

  # Returns the default topic for user. If no default topic exists for user
  # a new default topic will be created.
  def self.default_topic_for_user(user)
    default_topic = Topic.find_by(title: default_topic_name, user: user)
    if nil == default_topic
      default_topic = Topic.create!(title: default_topic_name, user: user)
    end
    default_topic
  end

private

  def default_topic_name
    "default"
  end
end
