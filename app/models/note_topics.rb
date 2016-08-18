class NoteTopic < ActiveRecord::Base
  belongs_to :note
  belongs_to :topic
end