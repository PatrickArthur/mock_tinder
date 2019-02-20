class CreateVotes < ActiveRecord::Migration[5.2]
  def change
    create_table :votes do |t|
      t.references :user
      t.references :picture
      t.boolean :vote, default: false
      t.timestamps
    end
  end
end
