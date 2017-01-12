require 'bundler/setup'
require 'spec_helper'
require 'rspec'
require_relative '../lib/order_my_lunch/restaurant'
require_relative '../lib/order_my_lunch/sold_out'
require_relative '../lib/order_my_lunch/sold_out_option'

RSpec.describe Restaurant do
  context 'when valid' do
    subject(:restaurant) { FactoryGirl.build :restaurant, :with_restaurant_a }
    it 'has a rating' do
      expect(restaurant.rating).to eq 5
    end

    it 'has a name' do
      expect(restaurant.name).to eq 'Restaurant A'
    end

    it 'has gluten free option' do
      expect(restaurant.has? :gluten_free).to be_truthy
    end

    it 'raises an error when an option is sold out' do
      expect(restaurant.has? :gluten_free).to be_truthy
      1.times do
        restaurant.place_order_for :gluten_free
      end
      expect(restaurant.has? :gluten_free).to be_falsey
      expect { restaurant.place_order_for :gluten_free }.to raise_error(SoldOutOption)
    end

    it 'raises an error when capacity is reached' do
      expect(restaurant.has? :gluten_free).to be_truthy
      1.times do
        restaurant.place_order_for :gluten_free
      end
      29.times do
        restaurant.place_order_for :other
      end
      expect(restaurant.has? :options).to be_falsey
      expect { restaurant.place_order_for :gluten_free }.to raise_error(SoldOut)
    end

  end
end