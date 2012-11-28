require "cinch/storage"
require "yaml"

module Cinch
  class Storage
    # A basic storage backed by YAML, using one file per plugin.
    class YAML < Storage
      # (see Storage#initialize)
      def initialize(options, plugin)
        # We are a basic example, so we load everything into memory. yey.
        @file = options.basedir + plugin.class.plugin_name + ".yaml"
        if File.exist?(@file)
          @yaml = ::YAML.load_file(@file) || {}
        else
          @yaml = {}
        end
        @options = options

        @mutex = Mutex.new
      end

      # (see Storage#[])
      def get(key)
        @yaml[key]
      end

      # (see Strage#[]=)
      def set=(key, value)
        @yaml[key] = value
      end

      # (see Storage#has_key?)
      def include?(key)
        @yaml.include?(key)
      end

      # (see Storage#delete)
      def delete(key)
        obj = @yaml.delete(key)
        obj
      end

      # (see Storage#save)
      def save
        @mutex.synchronize do
          File.open(@file, "w") do |f|
            f.write @yaml.to_yaml
          end
        end
      end

      # (see Storage#unload)
      def unload
      end
    end
  end
end
