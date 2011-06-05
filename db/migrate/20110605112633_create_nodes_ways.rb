class CreateNodesWays < ActiveRecord::Migration
  def self.up
    create_table :nodes_ways, :id => false do |t|
      t.references :nodes
      t.references :ways
    end
  end

  def self.down
    drop_table :nodes_ways
  end
end
