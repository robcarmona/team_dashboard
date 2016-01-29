class CreatePeerRotations < ActiveRecord::Migration
  def change
    create_table :peer_rotations do |t|
      t.date :date
      t.references :user
      t.integer :peer_user_id
      t.timestamps null: false
    end
  end
end
