[![Build Status](https://travis-ci.org/samsonnguyen/order_my_lunch.svg?branch=master)](https://travis-ci.org/samsonnguyen/order_my_lunch)

# Order My Lunch

Simple program that will order you the best lunch!

## Install

Ensure we install dependencies

    bundle install
    
    
## Usage

### Run as a script
Edit the parameters using `config/example.yml` then

    rake run
    
or

    ruby bin/order_my_lunch_runner.rb
    
### Run specs

    rake spec

## Background

Given 

* A list of restaurants, each capable or producing only a limited amount of stock daily
* restaurants each have a comparative rating. A 5 star restaurant is better than a 3 star restaurant
* A group/team of people to feed for lunch. Some with dietary restrictions such as vegetarian, nut free, gluten free
* Some restaurants can use their capacity for the day to fulfill some dietary restrictions. These dishes still count towards the maximum dailry capacity.
   
We want to find the optimum lunch order such that:

* We order from the best restaurants first
* All team members have a meal (if possible)
* Dietary restrictions are met (wherever possible)

Assumptions:

* People without a dietary restriction can have a dietary restricted meal (i.e. If you do not have restriction, you do not mind having a gluten free meal)
* If it is impossible to satisfy a restriction based on the list of restaurants and their stock, we choose the "normal" meal as an alternative (configurable via :allow_alternative parameter)


## Params

### Restaurants

| Parameter | Description | 
|--------------|---|
| name | Name of the restuarant |
| rating | Rating out of five |
| max_capacity | Maximum daily quota |
| menu | List of restricted items and their maximum amounts for the day |


### Team
| Parameter | Description | 
|---|---|
| total | Number of team members |
| details | List of restricted items and the number of people requesting this option |

### Base Params
| Parameter | Description | 
|---|---|
| allow_alternatives | In the event it is impossible to fulfill all dietary restrictions, fall back to normal meals to ensure all members have a lunch|