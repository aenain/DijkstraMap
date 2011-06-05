class CreateNodes < ActiveRecord::Migration
  def self.up
    create_table :nodes do |t|
      t.string :osm_id
      t.float :latitude
      t.float :longitude

      t.timestamps
    end

    add_index :nodes, :osm_id, :unique => true
  end

  def self.down
    drop_table :nodes
  end
end
