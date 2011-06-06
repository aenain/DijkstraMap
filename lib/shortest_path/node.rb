module ShortestPath
  class Node
    attr_accessor :id, :latitude, :longitude

    def initialize(options = {})
      raise ArgumentError unless options[:osm_id] && options[:latitude] && options[:longitude]

      @id = options[:osm_id].to_i
      @latitude = options[:latitude].to_f
      @longitude = options[:longitude].to_f
    end

    def ==(other)
      if other.is_a? ShortestPath::Node
        other.id == self.id || (other.latitude == self.latitude && other.longitude == self.longitude)
      else
        false
      end
    end
  end
end