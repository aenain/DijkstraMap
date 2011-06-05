function SvgMap(options) {
	this.settings = {
		text: { fill: 'white', fontSize: 8, fontFamily: 'Lucida Grande' },
		circle: { fill: '#5a91d6' },
		line: { fill: 'none', stroke: '#5a91d6', strokeWidth: 3 }
	}

	this.nodes = [];
  this.options = options; // minLon, maxLon, minLat, maxLat, nodes, svg (wrapper)
}

SvgMap.prototype.init = function() {
	this.convertAllCoordinates();
	this.drawPath();
	this.drawStart();
	this.drawFinish();
}

SvgMap.prototype.convertAllCoordinates = function() {
	for (var i = 0; i < this.options.nodes.length; i++) {
		var node = this.options.nodes[i];
		this.nodes.push(this.coordinates(node));
	}
}

SvgMap.prototype.coordinates = function(node) {
  var x = Math.round((node.longitude - this.options.min.lon) * this.options.width / (this.options.max.lon - this.options.min.lon));
  var y = Math.round((this.options.max.lat - node.latitude) * this.options.height / (this.options.max.lat - this.options.min.lat));

  return [x, y];
}

SvgMap.prototype.drawPath = function() {
	this.options.svg.polyline(this.nodes, this.settings.line);
}

SvgMap.prototype.drawStart = function() {
	var cx = this.nodes.first()[0];
	var cy = this.nodes.first()[1];

	this.options.svg.circle(cx, cy, 17, this.settings.circle);
	this.options.svg.text(cx - 9, cy + 2, 'Start', this.settings.text);
}

SvgMap.prototype.drawFinish = function() {
	var cx = this.nodes.last()[0];
	var cy = this.nodes.last()[1];

	this.options.svg.circle(cx, cy, 17, this.settings.circle);
	this.options.svg.text(cx - 11, cy + 2, 'Finish', this.settings.text);
}