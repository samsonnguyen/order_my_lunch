require_relative './order'
class Restaurant
  attr_accessor :name, :rating, :max_capacity
  attr_accessor :rating
  attr_accessor :options

  def initialize(options = {})
    @name                    = options[:name]
    @rating                  = options[:rating]
    @options                 = options
    @remaining               = @options[:max_capacity] || 0
    @remaining_items         = @options[:menu] || {}
    @remaining_items[:other] = @remaining
  end

  def has?(option)
    @remaining_items[option] && @remaining_items[option] > 0 && @remaining > 0
  end

  def place_order_for(choice, original = nil)
    if has? choice
      @remaining_items[choice] -= 1
      @remaining               -= 1
      Order.new(self, choice, original)
    elsif @remaining <= 0
      raise SoldOut
    else
      raise SoldOutOption
    end
  end

  def rating
    @rating
  end

  def name
    @name
  end
end