require 'bundler/setup'
require 'spec_helper'
require 'rspec'
require_relative '../lib/order_my_lunch'

RSpec.describe OrderMyLunch do

  let(:restaurant_a) { FactoryGirl.build :restaurant, :with_restaurant_a }
  let(:restaurant_b) { FactoryGirl.build :restaurant, :with_restaurant_b }

  context 'reasonable team' do
    let(:team) { {:total   => 50,
                  :details =>
                      {:vegetarian  => 10,
                       :gluten_free => 5,
                       :fish_free   => 2}
    } }

    context 'with substitutions' do
      subject(:order_my_lunch) { FactoryGirl.build :order_my_lunch, :with_substitutions }

      context 'with best lunch' do
        let(:lunch) { order_my_lunch.best_lunch_for(team) }

        it 'should be enough for everyone' do
          expect(lunch.lunch_order.size).to eq(team[:total])
        end

        it 'should accommodate reasonable restrictions' do
          expect(lunch.lunch_order.select { |order| order.option == :vegetarian }.size).to eq 10
          expect(lunch.lunch_order.select { |order| order.option == :gluten_free }.size).to eq 5
        end

        it 'should substitute with other if unavailable' do
          expect(lunch.lunch_order.select { |order| order.alternative == :fish_free }.size).to eq 1
          expect(lunch.lunch_order.select { |order| order.option == :fish_free }.size).to eq 1
        end

      end
    end

    context 'without substitutions' do
      subject(:order_my_lunch) { FactoryGirl.build :order_my_lunch, :without_substitutions }

      context 'with best lunch' do
        let(:lunch) { order_my_lunch.best_lunch_for(team) }

        it 'should not be enough for everyone' do
          expect(lunch.lunch_order.size).to eq(team[:total]-1)
        end

        it 'should accommodate reasonable restrictions' do
          expect(lunch.lunch_order.select { |order| order.option == :vegetarian }.size).to eq 10
          expect(lunch.lunch_order.select { |order| order.option == :gluten_free }.size).to eq 5
        end

        it 'should not substitute with other if unavailable' do
          expect(lunch.lunch_order.select { |order| order.alternative == :fish_free }.size).to eq 0
          expect(lunch.lunch_order.select { |order| order.option == :fish_free }.size).to eq 1
        end
      end
    end
  end


  context 'unreasonable team size' do
    let(:team) { {:total   => 200,
                  :details =>
                      {:vegetarian  => 10,
                       :gluten_free => 5}
    } }

    context 'with substitutions' do
      subject(:order_my_lunch) { FactoryGirl.build :order_my_lunch, :with_substitutions }

      context 'with best lunch' do
        let(:lunch) { order_my_lunch.best_lunch_for(team) }

        it 'should order everything possible' do
          expect(lunch.lunch_order.size).to eq(60)
        end

      end
    end

    context 'without substitutions' do
      subject(:order_my_lunch) { FactoryGirl.build :order_my_lunch, :without_substitutions }

      context 'with best lunch' do
        let(:lunch) { order_my_lunch.best_lunch_for(team) }

        it 'should order everything possible' do
          expect(lunch.lunch_order.size).to eq(60)
        end
      end
    end
  end

end