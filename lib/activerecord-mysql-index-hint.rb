require 'active_record'
require 'active_record/relation/query_methods'

module ActiveRecordMysqlIndexHint
  def use_index(*args)
    from_with_index_hint 'USE', *args
  end

  def force_index(*args)
    from_with_index_hint 'FORCE', *args
  end

  def ignore_index(*args)
    from_with_index_hint 'IGNORE', *args
  end

  private
  def from_with_index_hint(hint_type, *args)
    return self if args.blank?
    indexes = args.map {|index| connection.quote_column_name index }
    self.from("#{quoted_table_name} #{hint_type} INDEX(#{indexes.join(', ')})")
  end
end

ActiveRecord::Base.send :include, ActiveRecordMysqlIndexHint
ActiveRecord::Relation.send :include, ActiveRecordMysqlIndexHint
