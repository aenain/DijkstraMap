module OpenStreetMap
  class ConfigUpdater < Updater
    def update
      prepare_bounds
      update_config
      save_changes
    end

    private

    def prepare_bounds
      @prepared_bounds ||= { 'min' => { 'latitude' => bounds[:minlat].to_f, 'longitude' => bounds[:minlon].to_f },
                           'max' => { 'latitude' => bounds[:maxlat].to_f, 'longitude' => bounds[:maxlon].to_f } }
    end

    def update_config
      config["osm"]["bounds"] = prepare_bounds
      config["osm"]["image"]["dimensions"] = svg_dimensions.stringify_keys
    end

    def save_changes
      File.open(config_path, 'w') do |config_file|
        YAML.dump(config, config_file)
      end
    end
  end
end