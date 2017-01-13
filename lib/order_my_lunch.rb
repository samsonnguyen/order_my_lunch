require 'bundler/setup'
require_relative 'order_my_lunch/restaurant'
require_relative 'order_my_lunch/sold_out'
require_relative 'order_my_lunch/sold_out_option'

class OrderMyLunch
  attr_accessor :allow_alternatives, :lunch_order

  def initialize(options = {})
    @restaurant_list = []
    @lunch_order     = []

    @allow_alternatives = options[:allow_alternatives]
    options[:restaurant_list].each do |restaurant|
      @restaurant_list.push Restaurant.new(restaurant)
    end
    @restaurant_list.sort(&restaurants_by_rating)
  end

  def restaurants_by_rating
    Proc.new { |a, b|
      a.rating <=> b.rating
    }
  end

  def best_lunch_for(team)
    team[:details].each do |option, value|
      value.times do
        best_order = get_best_order_for(option, 0)
        unless best_order.nil?
          @lunch_order << best_order
        end
      end
    end
    remaining = team[:total] - team[:details].values.inject(0) { |sum, x| sum + x }
    remaining.times do
      best_order = get_best_order_for(:other, 0)
      unless best_order.nil?
        @lunch_order << best_order
      end
    end
    self
  end

  #  Recusively find the best option from our sorted list of restaurants
  def get_best_order_for(option, index, alternative = nil)
    begin
      if @restaurant_list[index]
        @restaurant_list[index].place_order_for(option, alternative)
      else
        if alternative.nil?
          get_best_order_for(:other, 0, option) if @allow_alternatives ## We can't accomodate restrictions
        else
          return nil
        end
      end
    rescue SoldOutOption, SoldOut
      get_best_order_for(option, index+1, alternative)
    end
  end

  def summary
    summary = ''
    @lunch_order.group_by { |order| order.restaurant }.each do |restaurant, orders_by_restaurant|
      summary << "#{restaurant.name}: [#{orders_by_restaurant.size}] orders\n"
      orders_by_restaurant.group_by { |order| order.option }.each do |option, orders_by_option|
        summary << "\t- [#{orders_by_option.size}] #{option}\n"
      end
    end

    summary
  end

  def list
    list = ''
    @lunch_order.each do |order|
      list << "#{order.to_s}\n"
    end
    list
  end

  def to_s
    summary
  end

end