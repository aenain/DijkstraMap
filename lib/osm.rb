require 'xmlsimple'

class Osm
  XmlSimple.xml_in(File.read(AppConfig.osm.source))
end