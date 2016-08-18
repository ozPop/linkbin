class CreateTopics < ActiveRecord::Migration[4.2]
  def change
    create_table :topics do |col|
      col.string :name
    end
  end
end
