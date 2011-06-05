class Node < ActiveRecord::Base
  has_and_belongs_to_many :ways

  validates_presence_of :osm_id, :latitude, :longitude
  validates_uniqueness_of :osm_id
  validates_numericality_of :latitude, :longitude
end
