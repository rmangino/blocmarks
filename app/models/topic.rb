class Topic < ActiveRecord::Base
  belongs_to :user
  has_many :bookmarks, dependent: :destroy

  validates :title, length: { minimum: 5 }

  # Always grab the newest Topics first
  default_scope { order('created_at DESC') }

  scope :visible_to, -> (user) { user ? where(user: user) : [] }

  def is_default_topic_for_user?(user)
    self == Topic.default_topic_for_user(user)
  end

  # Returns the default topic for user. If no default topic exists for user
  # a new default topic will be created.
  def self.default_topic_for_user(user)
    Topic.find_or_create_by(title: self.default_topic_name, user: user)
  end

  def self.default_topic_name
    "default"
  end
end
