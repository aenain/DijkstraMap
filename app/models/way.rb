class Way < ActiveRecord::Base
  has_and_belongs_to_many :nodes

  validates_presence_of :osm_id
  validates_uniqueness_of :osm_id
end
