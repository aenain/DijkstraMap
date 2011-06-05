module DijkstraHelper
  def svg_map_for_nodes_script_tag(nodes)
    image_url = AppConfig.osm.image.path.relative + "?" + Time.now.to_i.to_s
    bounds = AppConfig.osm.bounds

    script = <<-JS
      $(function() {
        $('#map').svg({loadURL: '#{image_url}', onLoad: function(svg) {
          var width = svg._svg.viewBox.baseVal.width;
          var height = svg._svg.viewBox.baseVal.height;
          var options = { width: width,
                          height: height,
                          min: { lat: #{bounds.min.latitude}, lon: #{bounds.min.longitude} },
                          max: { lat: #{bounds.max.latitude}, lon: #{bounds.max.longitude} },
                          nodes: #{nodes.to_json},
                          svg: svg };

          var svg_map = new SvgMap(options);
          document.svg_map = svg_map;

          svg_map.init();
        }});
      });
    JS

    javascript_tag script
  end

  def svg_map_integration_with_select_boxes_script_tag
    script = <<-JS
      $(function() {
        function coordinates_from_select($select) {
          var geographical = $select.find("option:selected").text().split(' ');

          for (var i = 0; i < geographical.length; i++)
            geographical[i] = parseFloat(geographical[i].slice(0, -1));

          return document.svg_map.coordinates({ latitude: geographical[0], longitude: geographical[1] });
        }

        function change_svg_element(element, changes) {
          document.svg_map.options.svg.change(element, changes);
        }

        $("#begin").change(function() {
          var coordinates = coordinates_from_select($(this));
          change_svg_element(document.svg_map.begin_point, { cx: coordinates[0], cy: coordinates[1] });
        });

        $("#end").change(function() {
          var coordinates = coordinates_from_select($(this));
          change_svg_element(document.svg_map.end_point, { cx: coordinates[0], cy: coordinates[1] });
        });
      });
    JS

    javascript_tag script
  end

  def nodes_grouped_by_way_for_select(ways, options = {})
    grouped_options = {}

    ways.each do |way|
      grouped_options[way.key] ||= []
      grouped_options[way.key] += way.nodes.collect do |node|
        ["#{node.latitude}N #{node.longitude}E", node.osm_id]
      end
    end

    grouped_options_for_select(grouped_options, options)
  end
end
