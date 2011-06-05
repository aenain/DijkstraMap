module ApplicationHelper
  def distance_to_human(distance)
    case distance
      when 10_000..40_000_000 then "#{distance / 1000}km"
      when 1_000...10_000 then "#{number_with_precision(distance / 1000.0, :precision => 1)}km"
      when 500...1_000 then "#{number_with_precision(distance / 1000.0, :precision => 2)}km"
      when 0...500 then "#{distance}m"
    end
  end
end
