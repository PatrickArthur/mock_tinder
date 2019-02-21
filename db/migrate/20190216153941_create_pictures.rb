class CreatePictures < ActiveRecord::Migration[5.2]
  def change
    create_table :pictures do |t|
      t.string :file
      t.text :description
      t.references :user
      t.datetime :viewed_at
    end
  end
end
