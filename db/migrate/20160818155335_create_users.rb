class CreateUsers < ActiveRecord::Migration[4.2]
  def change
    create_table :users do |col|
      col.string :username
      col.string :email
      col.string :password_digest
    end
  end
end
