#!/usr/bin/env ruby
require 'bundler/setup'
require 'yaml'
require_relative 'order_my_lunch/restaurant'
require_relative 'order_my_lunch/sold_out'
require_relative 'order_my_lunch/sold_out_option'

class OrderMyLunch
  attr_accessor :allow_alternatives

  def initialize(options = {})
    @restaurant_list    = []
    @allow_alternatives = options[:allow_alternatives]
    @lunch_order        = []
    load_restaurants(options[:restaurant_list])
  end

  def load_restaurants(config)
    list = YAML.load_file(config)
    list[:restaurants].each do |restaurant|
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
        @lunch_order << get_best_order_for(option, 0)
      end
    end
    remaining = team[:total] - team[:details].values.inject(0) { |sum, x| sum + x }
    remaining.times do
      @lunch_order << get_best_order_for(:other, 0)
    end
    self
  end

  #  Recusively find the best option from our sorted list of restaurants
  def get_best_order_for(option, index, alternative = nil)
    begin
      if @restaurant_list[index]
        @restaurant_list[index].place_order_for(option, alternative)
      else
        get_best_order_for(:other, 0, option) if @allow_alternatives ## We can't accomodate restrictions
      end
    rescue SoldOutOption, SoldOut
      get_best_order_for(option, index+1)
    end
  end

  def summary
    summary = ''
    @lunch_order.group_by { |order| order.restaurant }.each do |restaurant, orders_by_restaurant|
      summary << "#{restaurant.name}: Total of [#{orders_by_restaurant.size}] orders\n"
      orders_by_restaurant.group_by { |order| order.option }.each do |option, orders_by_option|
        summary << "\t[#{orders_by_option.size}] #{option}\n"
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

order_my_lunch = OrderMyLunch.new({:restaurant_list => "#{ File.join(File.dirname(__FILE__), '../config')}/restaurant_list.yml", :allow_alternatives => true})
final_order    = order_my_lunch.best_lunch_for(
    {:total   => 50,
     :details =>
         {:vegetarian  => 10,
          :gluten_free => 5}
    })
puts final_order.list