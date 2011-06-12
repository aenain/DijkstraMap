module OpenStreetMap
  class Updater
    def initialize options = {}
      @options = options
    end

    protected

    def reader
      @reader ||= Reader.new(@options)
    end
  end
end