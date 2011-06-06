module OpenStreetMap
  class Updater < Reader
    def initialize options = {}
      @options = options
    end

    def update *scopes
      XmlUpdater.new(@options).update if scopes.include?(:xml)
      SvgUpdater.new(@options).update if scopes.include?(:svg)
      SqlUpdater.new(@options).update if scopes.include?(:sql)
      ConfigUpdater.new(@options).update if scopes.include?(:config)
    end
  end
end