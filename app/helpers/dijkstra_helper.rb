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
end
