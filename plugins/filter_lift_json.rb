require "fluent/plugin/filter"

module Fluent::Plugin
  class LiftJsonFilter < Filter
    Fluent::Plugin.register_filter('lift_json', self)

    def filter(tag, time, record)
        begin
            record = record.merge JSON.parse(record['log'])
            record.delete 'log'
        rescue Exception
        end

        record
    end
  end
end
