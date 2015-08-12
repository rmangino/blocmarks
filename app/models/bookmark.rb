class Bookmark < ActiveRecord::Base
  belongs_to :topic
  validates :topic, presence: true
end
