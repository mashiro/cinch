require 'cinch/storage'
require 'sqlite3'
require 'base64'

module Cinch
  class Storage
    class SQLite3 < Storage
      class << self
        def database(name)
          @@database ||= ::SQLite3::Database.new name
        end
      end

      def initialize(options, plugin)
        @db = self.class.database File.join(options.basedir, 'sqlite3.db')
        @table_name = plugin.class.plugin_name

        @db.execute "create table if not exists #{@table_name} (key text primary key, value text)"
        @db.execute "create unique index if not exists idx_#{@table_name} on #{@table_name} (key);"
      end

      def get(key)
        rows = @db.execute "select value from #{@table_name} where key = ? limit 1", key
        deserialize rows[0][0] if rows[0]
      end

      def set(key, value)
        @db.execute "insert or replace into #{@table_name} values (?, ?)", key, serialize(value)
        value
      end

      def include?(key)
        rows = @db.execute "select count(key) from #{@table_name} where key = ?", key
        rows[0][0] > 0
      end

      def delete(key)
        @db.execute "delete from #{@table_name} where key = ?", key
        true
      end

      def save
      end

      def unload
      end

      private

      def serialize(value)
        Base64::encode64 Marshal.dump(value)
      end

      def deserialize(value)
        Marshal.load Base64::decode64(value)
      end
    end
  end
end
