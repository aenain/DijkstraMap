function SvgMap(options) {
	this.settings = {
		text: { fill: 'white', fontSize: 8, fontFamily: 'Lucida Grande' },
		circle: { fill: '#5a91d6' },
		line: { fill: 'none', stroke: '#5a91d6', strokeWidth: 4 },
		group: { opacity: 0.8 }
	}

	this.nodes = [];
  this.options = options; // minLon, maxLon, minLat, maxLat, nodes, svg (wrapper)
	this.svg = this.options.svg;
}

SvgMap.prototype.init = function() {
	this.convertAllCoordinates();
	this.createLayer();
	this.drawPath();
	this.drawStart();
	this.drawFinish();
	this.drawBeginPoint();
	this.drawEndPoint();
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

SvgMap.prototype.createLayer = function() {
	this.layer = this.svg.group(this.settings.group);
}

SvgMap.prototype.drawPath = function() {
	this.svg.polyline(this.layer, this.nodes, this.settings.line);
}

SvgMap.prototype.drawStart = function() {
	if (this.nodes.length > 0) {
		var cx = this.nodes.first()[0];
		var cy = this.nodes.first()[1];

		this.svg.circle(this.layer, cx, cy, 17, this.settings.circle);
		this.svg.text(this.layer, cx - 10, cy + 2, 'Start', this.settings.text);
	}
}

SvgMap.prototype.drawFinish = function() {
	if (this.nodes.length > 0) {
		var cx = this.nodes.last()[0];
		var cy = this.nodes.last()[1];

		this.svg.circle(this.layer, cx, cy, 17, this.settings.circle);
		this.svg.text(this.layer, cx - 12, cy + 2, 'Finish', this.settings.text);
	}
}

SvgMap.prototype.drawBeginPoint = function(cx, cy) {
	if (typeof cx == "undefined" || typeof cy == "undefined") {
		cx = -20;
		cy = -20;
	}

	this.beginPoint = this.svg.circle(this.layer, cx, cy, 8, this.settings.circle);
}

SvgMap.prototype.drawEndPoint = function(cx, cy) {
	if (typeof cx == "undefined" || typeof cy == "undefined") {
		cx = -20;
		cy = -20;
	}

	this.endPoint = this.svg.circle(this.layer, cx, cy, 8, this.settings.circle);
}

SvgMap.prototype.change = function(element, changes) {
	this.svg.change(element, changes);
}

// "50.1235N 19.1234E" -> [x, y] (on map)
SvgMap.prototype.coordinates_from_geographical = function(geographical) {
	var coordinates = geographical.split(' ');

	for (var i = 0; i < coordinates.length; i++)
		coordinates[i] = parseFloat(coordinates[i].slice(0, -1));

	return this.coordinates({ latitude: coordinates[0], longitude: coordinates[1] });
}