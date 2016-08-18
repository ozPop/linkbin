class Note < ActiveRecord::Base
  validates_presence_of :content, :links
  has_many :topics
  has_many :topics, through: :note_topics
end