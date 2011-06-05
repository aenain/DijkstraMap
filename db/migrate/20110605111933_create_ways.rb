class CreateWays < ActiveRecord::Migration
  def self.up
    create_table :ways do |t|
      t.string :osm_id
      t.string :name
      t.boolean :oneway, :default => false

      t.timestamps
    end

    add_index :ways, :osm_id, :unique => true
  end

  def self.down
    drop_table :ways
  end
end
