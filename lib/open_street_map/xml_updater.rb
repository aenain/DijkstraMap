module OpenStreetMap
  class XmlUpdater < Crawler
    def update
      download_and_save
      repair
    end

    private

    def download_and_save
      File.open(AppConfig.osm.source.path, 'w') do |file|
        file.write(download_xml)
      end
    end
  end
end