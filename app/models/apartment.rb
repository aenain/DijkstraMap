class Apartment
  attr_accessor :cost, :surface, :id, :location

  def initialize(options)
    @cost = options[:cost].to_f
    @surface = options[:surface].to_f
    @id = options[:id].to_i
    @location = options[:location]
  end

  def cost_per_meter_square
    @cost_per_meter_square ||= @cost / @surface
  end
end