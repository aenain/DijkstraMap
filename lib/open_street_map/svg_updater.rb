module OpenStreetMap
  class SvgUpdater < Crawler
    def update
      # download_and_save
      # it's not permitted by OpenStreetMap License
    end

    private

    def download_and_save
      File.open(AppConfig.osm.image.path.absolute, 'w') do |file|
        file.write(download_svg)
      end
    end

  end
end