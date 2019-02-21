class AddViewedAtPictures < ActiveRecord::Migration[5.2]
  def change
    add_column :pictures, :viewed_at, :datetime, default: nil
  end
end
