class CreateNodesWays < ActiveRecord::Migration
  def self.up
    create_table :nodes_ways, :id => false do |t|
      t.integer :node_id
      t.integer :way_id
    end
  end

  def self.down
    drop_table :nodes_ways
  end
end
