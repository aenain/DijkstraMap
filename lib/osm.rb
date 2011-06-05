require 'xmlsimple'

class Osm
  def initialize
    @osm_data = nil
  end

  def fill_db_with_osm_data
    prepare_db
    fetch_data
    # TODO! update info in AppConfig (dimensions of svg and bounds)
    create_nodes
    create_ways_and_connect_with_nodes
  end

  private

  def prepare_db
    clear_ways
    clear_nodes
  end
  
  def clear_ways
    Way.all.collect(&:destroy)
  end

  def clear_nodes
    Node.all.collect(&:destroy)
  end

  def fetch_data
    @osm_data ||= XmlSimple.xml_in(File.read(AppConfig.osm.source.path), { 'ForceArray' => ['way', 'node', 'nd', 'tag'] })
  end

  def create_nodes
    @osm_data["node"].each do |node|
      Node.create(:osm_id => node["id"], :latitude => node["lat"], :longitude => node["lon"])
    end
  end

  def create_ways_and_connect_with_nodes
    @osm_data["way"].each do |way|
      new_way = Way.create(:osm_id => way["id"], :name => fetch_name(way))

      way["nd"].each do |node|
        found_node = Node.find_by_osm_id(node["ref"]) rescue nil
        new_way.nodes << found_node unless found_node.nil?
      end
    end
  end

  def fetch_name(element)
    name = ""

    unless element["tag"].nil?
      element["tag"].each do |tag|
        name = tag["v"] if tag["k"] == "name"
      end
    end

    name
  end
end