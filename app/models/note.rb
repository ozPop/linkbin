class Note < ActiveRecord::Base
  validates_presence_of :content, :link
  has_many :topics
  has_many :topics, through: :note_topics
end