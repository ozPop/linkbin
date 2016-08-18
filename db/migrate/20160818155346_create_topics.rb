class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |col|
      col.string :name
    end
  end
end
