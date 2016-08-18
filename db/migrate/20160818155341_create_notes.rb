class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |col|
      col.text :content
      col.bool :private
      col.integer :user_id
    end
  end
end
