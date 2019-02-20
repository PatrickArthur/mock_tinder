class CreateLikes < ActiveRecord::Migration[5.2]
  def change
    create_table :likes do |t|
      t.references :user
      t.references :picture
      t.boolean :like_object
      t.timestamps
    end
  end
end
