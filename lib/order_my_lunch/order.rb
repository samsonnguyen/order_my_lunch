class Order
  attr_accessor :restaurant, :option, :alternative

  def initialize(restaurant, option, alternative = nil)
    @restaurant  = restaurant
    @option      = option
    @alternative = alternative
  end

  def option
    @option
  end

  def restaurant
    @restaurant
  end

  def to_s
    "'#{@option.to_s.capitalize }' option from '#{@restaurant.name}'#{" (Replacement for #{@alternative.to_s.capitalize})" if @alternative}"
  end
end