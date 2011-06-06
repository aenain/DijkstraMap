require 'xmlsimple'
require 'rmagick'

module OpenStreetMap
  class Reader
    def initialize options = {}
      @options = options
    end

    def map
      @map ||= XmlSimple.xml_in(File.read(@options[:osm_source] || AppConfig.osm.source.path), { 'ForceArray' => ['way', 'node', 'nd', 'tag'] })
    end

    def config
      @config ||= YAML.load(File.read(config_path))
    end

    def config_path
      @config_path ||= Rails.root.join('config', 'app_config.yml')
    end

    def svg_dimensions
      return @svg_dimensions unless @svg_dimensions.nil?

      svg = Magick::Image::read(AppConfig.osm.image.path.absolute).first
      @svg_dimensions = { :width => svg.columns, :height => svg.rows }
    end

    def bounds
      @bounds ||= map["bounds"].symbolize_keys rescue {}
    end

    def ways
      @ways ||= map["way"] rescue []
    end

    def nodes way = nil, options = {}
      if way.nil?
        @nodes ||= map["node"] rescue []
      elsif options[:tag].present?
        way[options[:tag]]
      else
        way["nd"].collect { |node| node["ref"] } rescue []
      end
    end

    def node_params node
      { :osm_id => node["id"], :latitude => node["lat"].to_f, :longitude => node["lon"].to_f } rescue {}
    end

    def way_params way, options = {}
      { :osm_id => way["id"], :name => name(way, options[:name] || {}) }
    end

    def name element, options = {}
      attribute = options[:attr]
      return element[attribute] unless attribute.nil?

      tag = (element["tag"] || []).delete_if { |tag| tag["k"] != "name" }.first
      name = tag["v"] rescue ""
    end

    def distance element
      element["distance"].to_f rescue 0.0
    end
  end
end