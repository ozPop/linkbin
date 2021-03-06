class CreateNotes < ActiveRecord::Migration[4.2]
  def change
    create_table :notes do |col|
      col.string :description
      col.text :content
      col.string :links, :array => true
      col.datetime :date_created
      col.datetime :date_updated
      col.boolean :public_access
      col.integer :user_id
    end
  end
end