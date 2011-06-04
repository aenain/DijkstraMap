require 'dijkstra'

class DijkstraController < ApplicationController
  def run
    @begin_id = params[:begin]
    @end_id = params[:end]

    dijkstra = Dijkstra.new(@begin_id, @end_id)
    dijkstra.run

    @route = dijkstra.route
    @nodes = dijkstra.nodes.to_json
  end
end
