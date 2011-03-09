module ActiveRecord

  class Base
    before_save(:_clean_whitespace)

    def _clean_whitespace
      self.attributes.each_pair do |key, value|
        if value && value.respond_to?('strip')
          self[key] = value.strip
        end
      end
    end

    def to_hash(*fields)
      h = attributes.symbolize_keys
      fields.present? ? h.slice(*fields.flatten) : h
    end

    class << self
      def conditions(*args)
        scoped :conditions => args
      end

      def date_range(options)
        options.reverse_merge! :field => "created_at", :start => Time.now, :end => Time.now
        scoped :conditions => { options[:field] => options[:range] || (options[:start].beginning_of_day..options[:end].end_of_day) }
      end

      def sort_scope(options)
        scoped :order => "#{options[:attribute]} #{options[:direction]}"
      end

      def random(_limit=1)
        scoped :order => "RAND()", :limit => _limit
      end

      def limit(_limit)
        scoped :limit => _limit
      end
    end
  end

end
