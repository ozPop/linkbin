class CreateNoteTopics < ActiveRecord::Migration
  def change
    create_table :note_topics do |col|
      col.integer :note_id
      col.integer :topic_id
    end
  end
end
