[![Build Status](https://travis-ci.org/mirakui/activerecord-mysql-index-hint.png)](https://travis-ci.org/mirakui/activerecord-mysql-index-hint)

# activerecord-mysql-index-hint

MySQL index hint support for ActiveRecord

## Installation

Add this line to your application's Gemfile:

    gem 'activerecord-mysql-index-hint'

## Usage

    class Product < ActiveRecord::Base
    end

    Product.where(user_id: 1).force_index(:idx_user_id).first
    # => SELECT `products`.* FROM `products` FORCE INDEX(`idx_user_id`) WHERE `products`.`user_id` = 1 LIMIT 1
