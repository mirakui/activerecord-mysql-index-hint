require 'active_record'
require 'mysql2'
require 'active_record/connection_adapters/mysql2_adapter'
require 'activerecord-mysql-index-hint'

module Mysql2
  class Client
    def initialize(opts={})
      @query_options = @@default_query_options.dup.merge opts
    end
  end
end

module ActiveRecord
  module ConnectionAdapters
    class Mysql2Adapter
      def quote_string(string)
        string
      end
      def configure_connection
      end
    end
  end
end

class Product < ActiveRecord::Base
  establish_connection 'mysql2://user@host/db'
end

describe 'ActiveRecord Index Hint' do
  context 'with AR::Relation' do
    it do
      expect(
        Product.all.use_index(:idx1).limit(1).to_sql
      ).to eq('SELECT  `products`.* FROM `products` USE INDEX(`idx1`)  LIMIT 1')
    end

    it do
      expect(
        Product.all.force_index(:idx1).limit(1).to_sql
      ).to eq('SELECT  `products`.* FROM `products` FORCE INDEX(`idx1`)  LIMIT 1')
    end

    it do
      expect(
        Product.all.ignore_index(:idx1).limit(1).to_sql
      ).to eq('SELECT  `products`.* FROM `products` IGNORE INDEX(`idx1`)  LIMIT 1')
    end
  end

  context 'with AR::Base' do
    it do
      expect(
        Product.use_index(:idx1).limit(1).to_sql
      ).to eq('SELECT  `products`.* FROM `products` USE INDEX(`idx1`)  LIMIT 1')
    end
  end

  context 'with multiple indexes' do
    it do
      expect(
        Product.all.use_index(:idx1, :idx2).limit(1).to_sql
      ).to eq('SELECT  `products`.* FROM `products` USE INDEX(`idx1`, `idx2`)  LIMIT 1')
    end
  end
end
