class Statistics
  attr_reader :trust, :predicted

  def initialize options = {}
    raise ArgumentError if options[:apartments].blank? || options[:predicted].nil?

    @apartments = options[:apartments]
    @trust = options[:trust] || 0.05
    @predicted = options[:predicted]
  end

  def sum
    @sum ||= @apartments.inject(0) { |total, apartment| total + apartment.cost_per_meter_square }
  end

  def average
    @average ||= sum / n.to_f
  end

  def deviation
    return @deviation unless @deviation.nil?

    sum_of_squares = @apartments.inject(0) { |total, apartment| total + (apartment.cost_per_meter_square - average)**2 }
    @deviation = Math.sqrt(sum_of_squares / n)
  end

  def normalized
    @normalized ||= (average - predicted) * Math.sqrt(n) / deviation
  end

  def critical_set_for_equal_hypothesis
    t = student_distribution :trust => trust, :length => n

    unless t.nil?
      "(-&infin;, #{-t}> &cup; <#{t}, +&infin;)"
    else
      "Don't know how to build critical set."
    end
  end

  def equal_hypothesis_is_good?
    -student_distribution >= normalized || normalized <= student_distribution
  end

  def n
    @n ||= @apartments.length
  end

  def student_distribution options = {}
    trust_lvl = options[:trust] || trust
    length = options[:length] || n

    from_trust = 1 - trust_lvl / 2
    from_length = length - 1

    if from_length == 29 && from_trust == 0.975
      2.05 # 2.04523
    else
      nil
    end
  end
end