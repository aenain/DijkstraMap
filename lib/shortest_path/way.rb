module ShortestPath
  class Way
    include ApplicationHelper
    include ActionView::Helpers::NumberHelper

    attr_accessor :id, :name, :distance, :nodes

    def initialize(options = {})
      Rails.logger.info options
      raise ArgumentError unless options[:osm_id]

      @id = options[:osm_id].to_i
      @name = options[:name] || "..."
      @distance = options[:distance].to_i rescue 0
      @nodes = []
    end

    def to_s
      "#{distance_to_human(@distance)} #{@name}"
    end

  end
end