module ShortestPath
  class Way
    include ApplicationHelper
    include ActionView::Helpers::NumberHelper

    attr_accessor :id, :name, :distance, :nodes

    def initialize(options = {})
      raise ArgumentError unless options[:id]

      @id = options[:id].to_i
      @name = options[:name] || "..."
      @distance = options[:distance].to_i rescue 0
      @nodes = []
    end

    def to_s
      "#{distance_to_human(@distance)} #{@name}"
    end

  end
end