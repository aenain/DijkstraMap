module ShortestPath
  class Node
    attr_accessor :id, :latitude, :longitude

    def initialize(options = {})
      raise ArgumentError unless options[:id] && options[:lat] && options[:lon]

      @id = options[:id].to_i
      @latitude = options[:lat].to_f
      @longitude = options[:lon].to_f
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