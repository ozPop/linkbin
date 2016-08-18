class CreateNotes < ActiveRecord::Migration[4.2]
  def change
    create_table :notes do |col|
      col.text :content
      col.string :links, :array => true
      col.datetime :date
      col.boolean :private
      col.integer :user_id
    end
  end
end
