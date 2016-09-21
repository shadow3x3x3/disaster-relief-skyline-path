require "ruby-skyline-core"

# EXT Array
class Array
  # skyline attributes aggregate for array
  def aggregate(array, type = 'normal')
    case type
    when 'normal'
      return aggregate_normal(array)
    when 'max'
      return aggregate_max(array)
    when 'min'
      return aggregate_min(array)
    end
  end

  def aggregate_normal(array)
    aggregate_array = []
    each_with_index do |attr, index|
      aggregate_array << (attr + array[index]).round(6)
    end
    aggregate_array
  end

  def aggregate_max(array)
    aggregate_array = []
    each_with_index do |attr, index|
      aggregate_array << (attr > array[index] ? attr : array[index])
    end
    aggregate_array
  end

  def aggregate_min(array)
    aggregate_array = []
    each_with_index do |attr, index|
      aggregate_array << (attr < array[index] ? attr : array[index])
    end
    aggregate_array
  end
end
