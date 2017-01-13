#!/usr/bin/env ruby
require 'bundler/setup'
require 'yaml'
require 'pp'
require_relative '../lib/order_my_lunch'

begin
  config         = YAML.load_file("#{ File.join(File.dirname(__FILE__), '../config')}/example.yml")
  order_my_lunch = OrderMyLunch.new({:restaurant_list    => config[:restaurants],
                                     :allow_alternatives => config[:allow_alternatives]})
  final_order    = order_my_lunch.best_lunch_for config[:team]
  # puts final_order.list

  pp config

  puts final_order.summary
end