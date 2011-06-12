module OpenStreetMap
  class DatabaseUpdater < Updater
    def update
      clear_nodes_and_ways
      create_nodes
      create_ways_with_connections
    end

    private

    def clear_nodes_and_ways
      clear_ways
      clear_nodes
    end

    def create_nodes
      reader.nodes.each do |node|
        Node.create reader.node_params(node)
      end
    end

    def create_ways_with_connections
      reader.ways.each do |way|
        created_way = Way.create reader.way_params(way)
        bind_way_with_nodes created_way, reader.nodes(way)
      end
    end

    def bind_way_with_nodes(way, nodes)
      nodes.each do |node_id|
        node = Node.find_by_osm_id(node_id)
        way.nodes << node unless node.nil?
      end
    end

    def clear_ways
      Way.all.collect(&:destroy)
    end

    def clear_nodes
      Node.all.collect(&:destroy)
    end
  end
end