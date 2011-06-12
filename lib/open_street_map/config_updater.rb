module OpenStreetMap
  class ConfigUpdater < Updater
    def update
      prepare_bounds
      update_config
      save_changes
    end

    private

    def prepare_bounds
      @prepared_bounds ||= { 'min' => { 'latitude' => reader.bounds[:minlat].to_f, 'longitude' => reader.bounds[:minlon].to_f },
                             'max' => { 'latitude' => reader.bounds[:maxlat].to_f, 'longitude' => reader.bounds[:maxlon].to_f } }
    end

    def update_config
      reader.config["osm"]["bounds"] = prepare_bounds
      reader.config["osm"]["image"]["dimensions"] = reader.svg_dimensions.stringify_keys
    end

    def save_changes
      File.open(reader.config_path, 'w') do |config_file|
        YAML.dump(reader.config, config_file)
      end
    end
  end
end