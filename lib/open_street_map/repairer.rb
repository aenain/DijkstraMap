module OpenStreetMap
  class Repairer
    def initialize
      @file = AppConfig.osm.source.path
    end

    def repair
      read_file
      repair_source
      save_changes
    end

    private

    def file
      @file ||= AppConfig.osm.source.path
    end

    def read_file
      @source ||= File.read(file)
    end

    def repair_source
      @source = @source.lines.to_a.each do |line|
        # Rule: one tag per line
        # "<tag ... />" => "<tag ...></tag>"
        line.gsub!(/<([[:alnum:]]+)(.*)\/>/, '<\1\2></\1>') if line =~ /\/>\s*$/
      end

      if @source.first =~ /<\?xml/
        @source.shift
      end
    end

    def save_changes
      File.open(file, 'w') do |xml|
        xml.write @source.join
      end
    end
  end
end