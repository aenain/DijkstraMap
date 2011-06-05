class Way < ActiveRecord::Base
  has_and_belongs_to_many :nodes

  validates_presence_of :osm_id
  validates_uniqueness_of :osm_id

  def key
    if name.present?
      "#{name} (#{osm_id})"
    else
      "No name (#{osm_id})"
    end
  end
end
