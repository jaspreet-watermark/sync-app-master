# encoding: UTF-8
# frozen_string_literal: true

module Serializers
  class ItemEvent
      def call(item)
        {
            master_id: item.id.to_s,
            title: item.title,
            description: item.description,
            status: item.status,
            deleted_at: item.deleted_at
        }.to_json
      end

      class << self
        def call(item)
          new.call(item)
        end
      end
    end
end
