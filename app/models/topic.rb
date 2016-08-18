class Topic < ActiveRecord::Base
  validates_presence_of :name
  has_many :note_topics
  has_many :notes, through: :note_topics
end