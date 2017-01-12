require 'bundler/setup'
require 'spec_helper'
require 'rspec'
require_relative '../lib/order_my_lunch/restaurant'
require_relative '../lib/order_my_lunch/sold_out'
require_relative '../lib/order_my_lunch/sold_out_option'

RSpec.describe OrderMyLunch do

  let(:restaurant_a) { FactoryGirl.build :restaurant, :with_restaurant_a }
  let(:restaurant_b) { FactoryGirl.build :restaurant, :with_restaurant_b }

  context 'allow substitutions' do

  end

  context 'not allowed substitutions' do

  end
end