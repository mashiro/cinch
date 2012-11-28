module Cinch
  # @note The interface of this class isn't fixed yet. You shouldn't
  #   use it yet.
  class Storage
    autoload :Null, 'cinch/storage/null'
    autoload :YAML, 'cinch/storage/yaml'
    autoload :SQLite3, 'cinch/storage/sqlite3'

    # @param [Hash] options
    # @param [Plugin] plugin
    def initialize(options, plugin)
    end

    # @param [Object] key
    # @return [Object, nil]
    def get(key)
      raise NotImprementError
    end

    def [](key)
      get key
    end

    # @param [Object] key
    # @param [Object] value
    # @return [value]
    def set(key, value)
      raise NotImprementError
    end

    def []=(key, value)
      set key, value
    end

    # @param [Object] key
    # @return [Boolean]
    def include?(key)
      raise NotImprementError
    end

    # @param [Object] key
    # @return [Object, nil] The deleted object
    def delete(key)
      raise NotImprementError
    end

    def save
    end

    def unload
    end
  end
end
