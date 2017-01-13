#!/usr/bin/env ruby
require 'bundler/setup'
require 'yaml'
require 'pp'
require_relative '../lib/order_my_lunch'

begin
  yaml         = YAML.load_file("#{ File.join(File.dirname(__FILE__), '../config')}/example.yml")
  order_my_lunch = OrderMyLunch.new({:restaurant_list    => yaml[:restaurants],
                                     :allow_alternatives => yaml[:allow_alternatives]})
  final_order    = order_my_lunch.best_lunch_for yaml[:team]
  # puts final_order.list

  puts "======== Parameters ========"
  pp yaml

  puts "======== Summary of your order ========"
  puts final_order.summary
end