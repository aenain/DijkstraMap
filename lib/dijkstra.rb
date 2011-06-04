class Dijkstra
  attr_reader :route, :nodes

  def initialize(begin_id, end_id)
    @begin_id = begin_id
    @end_id = end_id
    @route = []
    @nodes = []
  end

  def run
    @result = %x{ cd ~/Desktop; ./Dijkstra.debug #{@begin_id} #{@end_id} ~/Downloads/map.osm }
    Rails.logger.info @result

    fetch_route_from_output(@result)
    fetch_nodes_from_output(@result)
  end

  private

  def fetch_route_from_output(result)
    result.split(/\n/).each do |line|
      if line =~ /^\d+\w+\s.+$/
        @route << line
      end
    end
  end

  def fetch_nodes_from_output(result)
    result.split(/\n/).each do |line|
      if matched = line.match(/^([0-9.]+)\s([0-9.]+)$/)
        @nodes << [matched[1].to_f, matched[2].to_f]
      end
    end
  end
end