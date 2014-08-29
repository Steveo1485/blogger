class AddActivatedAtToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :activated_at, :timestamp
  end
end
