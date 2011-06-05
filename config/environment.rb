# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
DijkstraMap::Application.initialize!

# By default is html5
Haml::Template.options[:format] = :xhtml