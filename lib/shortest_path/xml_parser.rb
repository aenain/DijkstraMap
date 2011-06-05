require 'xmlsimple'

module ShortestPath
  class XmlParser
    attr_reader :ways, :nodes

    def initialize
      @ways = []
      @nodes = []
    end

    def parse_file(filepath)
      path = XmlSimple.xml_in(File.read(filepath), { 'ForceArray' => ['way', 'node'] })

      path["way"].each do |way|
        @ways << ShortestPath::Way.new(:id => way["id"], :name => way["name"], :distance => way["distance"])

        way["node"].each do |node|
          new_node = ShortestPath::Node.new(node.symbolize_keys)
          @ways.last.nodes << new_node
          @nodes << new_node unless @nodes.include?(new_node)
        end
      end 
      # config["begin"], config["end"] - id of first and last node
      # path["way"][n] - nth way
      # path["way"][n]["node"][m] - mth node of nth way
    end
  end
end