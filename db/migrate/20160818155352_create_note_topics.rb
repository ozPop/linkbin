class CreateNoteTopics < ActiveRecord::Migration[4.2]
  def change
    create_table :note_topics do |col|
      col.integer :note_id
      col.integer :topic_id
    end
  end
end
