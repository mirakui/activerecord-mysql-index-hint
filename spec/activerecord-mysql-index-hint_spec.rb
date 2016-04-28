require 'active_record'
require 'active_record/connection_adapters/mysql2_adapter'
require 'activerecord-mysql-index-hint'

module ActiveRecord
  module ConnectionHandling
    prepend Module.new {
      def mysql2_connection(config)
        ConnectionAdapters::Mysql2Adapter.new(nil, logger, nil, config)
      end
    }
  end

  module ConnectionAdapters
    class Mysql2Adapter
      prepend Module.new {
        def quote_string(string)
          string
        end

        def reconnect!
        end

        def configure_connection
        end

        def full_version
          "5.0.0"
        end
      }
    end
  end
end

Arel::Visitors::ToSql.class_eval do
  def column_for o
    nil
  end
end

class Product < ActiveRecord::Base
  establish_connection 'mysql2://user@host/db'
end

def normalize_spaces(sql)
  sql.gsub(/ {2,}/, ' ')
end

describe 'ActiveRecord Index Hint' do
  context 'with AR::Relation' do
    it do
      expect(
        normalize_spaces Product.limit(1).use_index(:idx1).to_sql
      ).to eq('SELECT `products`.* FROM `products` USE INDEX(`idx1`) LIMIT 1')
    end

    it do
      expect(
        normalize_spaces Product.limit(1).force_index(:idx1).to_sql
      ).to eq('SELECT `products`.* FROM `products` FORCE INDEX(`idx1`) LIMIT 1')
    end

    it do
      expect(
        normalize_spaces Product.limit(1).ignore_index(:idx1).to_sql
      ).to eq('SELECT `products`.* FROM `products` IGNORE INDEX(`idx1`) LIMIT 1')
    end
  end

  context 'with AR::Base' do
    it do
      expect(
        normalize_spaces Product.use_index(:idx1).limit(1).to_sql
      ).to eq('SELECT `products`.* FROM `products` USE INDEX(`idx1`) LIMIT 1')
    end
  end

  context 'with multiple indexes' do
    it do
      expect(
        normalize_spaces Product.limit(1).use_index(:idx1, :idx2).to_sql
      ).to eq('SELECT `products`.* FROM `products` USE INDEX(`idx1`, `idx2`) LIMIT 1')
    end
  end
end
