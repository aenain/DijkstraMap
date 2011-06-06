module OpenStreetMap
  class SqlUpdater < Updater
    def update
      prepare_database
      create_nodes
      create_ways_with_connections
    end

    private

    def prepare_database
      clear_ways
      clear_nodes
    end

    def create_nodes
      nodes.each do |node|
        Node.create node_params(node)
      end
    end

    def create_ways_with_connections
      ways.each do |way|
        created_way = Way.create way_params(way)
        bind_way_with_nodes created_way, nodes(way)
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