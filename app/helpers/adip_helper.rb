module AdipHelper
  def number number
    number_with_precision(number, :precision => 2)
  end
end
