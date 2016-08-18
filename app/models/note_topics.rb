class Topic < ActiveRecord::Base
  belongs_to :note
  belongs_to :topic
end