require 'forwardable'

module Cinch
  class Storage
    autoload :Null, 'cinch/storage/null'
    autoload :YAML, 'cinch/storage/yaml'
    autoload :SQLite3, 'cinch/storage/sqlite3'

    extend Forwardable
    def_delegator :self, :get, :[]
    def_delegator :self, :set, :[]=

    def initialize(options, plugin)
    end

    def get(key)
      raise NotImprementError
    end

    def set(key, value)
      raise NotImprementError
    end

    def include?(key)
      data = get key
      !!data
    end

    def delete(key)
      raise NotImprementError
    end

    def save
    end

    def unload
    end
  end
end
