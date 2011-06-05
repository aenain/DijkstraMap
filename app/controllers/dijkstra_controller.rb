require 'dijkstra'

class DijkstraController < ApplicationController
  before_filter :set_svg_size, :only => :run
  before_filter :set_ways, :only => :run

  def run
    dijkstra = Dijkstra.new(params[:begin], params[:end])
    dijkstra.run

    @path_ways = dijkstra.ways
    @path_nodes = dijkstra.nodes
  end

  private

  def set_ways
    @ways = Way.all
  end

  def set_svg_size
    @svg_width = AppConfig.osm.image.width
    @svg_height = AppConfig.osm.image.height
  end
end
