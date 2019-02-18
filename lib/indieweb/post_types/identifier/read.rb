require "indieweb/post_types/identifier/read/version"

module Indieweb
  module PostTypes
    module Identifier
      module Read
        def self.type_from(data)
          data = entry_data_from(data)
          return unless data.key?('read-of')

          'read'
        end

        private

        def self.entry_data_from(data)
          return data['properties'] if data.key?('properties')
          return data unless data.key?('items')
          data['items'].first['properties']
        end
      end
    end
  end
end
