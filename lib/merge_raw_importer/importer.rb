
module MergeRawImporter
  class Importer
    require 'roo'
    attr_accessor :table_name, :file

    RECORDS_AT_ONCE = 500

    def initialize(args = {})
      self.file = args[:file]
      self.table_name = args[:table_name]
    end

    def import(file = self.file)
      self.file = file
      ensure_params!
      set_table_name
      open_file
      extract_columns
      extract_business_index

      ActiveRecord::Base.transaction do
        upsert_into_table_name
      end

    rescue Exception => e
      puts e.message
      puts e.backtrace
      fail e.message
    end

    private

    attr_accessor :business_index_columns, :xlsx, :columns

    def open_file
      self.xlsx = Roo::Spreadsheet.open(file)
    end

    def extract_business_index
      self.business_index_columns = ActiveRecord::Base.connection.indexes(table_name).find do |i|
        i.name == "#{table_name}_business_index"
      end.try(:columns).try(:join, ', ')
    end

    def extract_columns
      cols = {}
      sql = "SELECT column_name, data_type FROM information_schema.columns WHERE table_name = '#{table_name}'"
      db_cols = {}
      ActiveRecord::Base.connection.execute(sql).to_a.each{|column| db_cols[column['column_name']] = column['data_type']}

      xlsx.sheet(0).row(1).each do |field|
        cols[field.to_sym] = db_cols[field]
      end

      if db_cols['created_at'].present?
        cols[:created_at] = :datetime
        cols[:updated_at] = :datetime
      end
      self.columns = cols
    end

    def execute(sql)
      ActiveRecord::Base.connection.execute(sql)
    end

    def sql_statement(values)
      insert + fields + values + on_conflict
    end

    def insert
      "insert into #{table_name} "
    end

    def fields
      "(#{columns.keys.join(', ')})"
    end

    def upsert_into_table_name
      str = " values "
      str_array = []
      xlsx.sheet(0).each_with_index do |row, i|
        next if i == 0
        str_array << value_array(row)
        if (i % RECORDS_AT_ONCE) == 0
          values = str + str_array.join(',')
          execute sql_statement(values)
          str_array = []
        end
      end
      if str_array.any?
        values = str + str_array.join(',')
        execute sql_statement(values)
      end
    end

    def value_array row
      str_row = []
      columns.each_with_index do |column, i|
        if [:created_at, :updated_at].include?(column[0])
          str_row << "'#{Time.now.to_s}'"
        elsif [:boolean].include?(column[1])
          str_row << (row[i] == true or row[i] == 1)
        elsif [:integer, :float, :double, :boolean].include?(column[1])
          str_row << row[i]
        else
          str_row << (row[i].present? ? "'#{row[i]}'" : 'NULL')
        end
      end
      '(' + str_row.join(',') + ')'
    end

    def on_conflict
      str = " on conflict (#{business_index_columns}) do update set "
      str_array = []
      columns.keys.each do |column|
        str_array << "#{column} = excluded.#{column}"
      end
      str + str_array.join(', ')
    end

    def set_table_name
      if table_name.nil?
        self.table_name =  File.basename(file).split(".").first
      end
    end

    def ensure_params!
      fail 'Filename not specified' if file.nil?
    end
  end
end

#insert into product_types (name, deleted, created_at, updated_at)
#(select name, deleted, created_at, updated_at from product_types2) on conflict(name) do update set name= excluded.name, deleted = excluded.deleted