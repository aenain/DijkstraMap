require 'xmlsimple'

module ShortestPath
  class XmlParser
    attr_reader :ways, :nodes

    def initialize
      @ways = []
      @nodes = []
    end

    def parse_file(file)
      reader = OpenStreetMap::Reader.new(:osm_source => AppConfig.dijkstra.result.path)

      unless reader.ways.nil?
        reader.ways.each do |way|
          @ways << ShortestPath::Way.new(reader.way_params(way, :name => { :attr => 'name' }).merge({ :distance => reader.distance(way) }))

          reader.nodes(way, :tag => 'node').each do |node|
            new_node = ShortestPath::Node.new(reader.node_params(node))
            @ways.last.nodes << new_node
            @nodes << new_node unless @nodes.include?(new_node)
          end

        end
      end

    end
  end
end