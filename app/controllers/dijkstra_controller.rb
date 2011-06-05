require 'dijkstra'

class DijkstraController < ApplicationController
  before_filter :check_nodes_for_dijkstra, :only => :run
  before_filter :set_svg_size, :only => :run
  before_filter :set_ways, :only => :run

  def run
    dijkstra = Dijkstra.new(params[:begin], params[:end])
    dijkstra.run if request.post? && @valid_params

    @path_ways = dijkstra.ways
    @path_nodes = dijkstra.nodes

    @total_distance = @path_ways.sum(0) { |way| way.distance }

    @begin = params[:begin]
    @end = params[:end]
  end

  private

  def check_nodes_for_dijkstra
    @valid_params = params[:begin] && params[:end] && params[:begin] != params[:end]
  end

  def set_ways
    @ways = Way.all(:include => :nodes).delete_if { |way| way.name.empty? }.sort_by(&:name)
  end

  def set_svg_size
    @svg_width = AppConfig.osm.image.width
    @svg_height = AppConfig.osm.image.height
  end
end
