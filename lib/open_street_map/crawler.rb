require 'net/http'

module OpenStreetMap
  class Crawler < Repairer
    attr_reader :min_latitude, :min_longitude, :max_latitude, :max_longitude, :scale

    def initialize options = {}
      raise "Can't update xml and svg without bounds." unless bounds_valid?(options)

      @min_latitude = options[:minlat]
      @min_longitude = options[:minlon]
      @max_latitude = options[:maxlat]
      @max_longitude = options[:maxlon]

      @scale = options[:scale] || 5000
    end

    def update
      XmlUpdater.new.update
      SvgUpdater.new.update
    end

    def download_xml
      return @xml unless @xml.nil?

      source_url = URI.parse("http://api.openstreetmap.org/api/0.6/map?bbox=#{min_longitude},#{min_latitude},#{max_longitude},#{max_latitude}")
      @xml = Net::HTTP.get_response(source_url).body.force_encoding('utf-8')
    end

    def download_svg
      # return @svg unless @svg.nil?
      # 
      # source_url = URI.parse("http://tile.openstreetmap.org/cgi-bin/export?bbox=#{min_longitude},#{min_latitude},#{max_longitude},#{max_latitude}&scale=#{scale}&format=svg")
      # @svg = Net::HTTP.get_response(source_url).body
    end

    private

    def bounds_valid? options = {}
      options[:minlat] && options[:minlon] && options[:maxlat] && options[:maxlon]
    end
  end
end