namespace :osm do
  desc "After changing map.osm or map.svg run this task to update config file and database. It also repairs map.osm for Dijkstra."
  task :update => [:repair_osm_source, :update_config, :update_db]

  desc "Updates config (with data from map.osm and map.svg)."
  task :update_config => :environment do |task|
    puts "Updating config..."
    OpenStreetMap::ConfigUpdater.new.update
  end

  desc "Updates database (removes all ways and nodes, then creates ways and nodes from map.osm)."
  task :update_db => :environment do |task|
    puts "Updating database..."
    OpenStreetMap::DatabaseUpdater.new.update
  end

  desc "Repairs map.osm for use in Dijkstra (eg. removes xml declaration)."
  task :repair_osm_source => :environment do |task|
    puts "Repairing osm source..."
    OpenStreetMap::Repairer.new.repair
  end
end