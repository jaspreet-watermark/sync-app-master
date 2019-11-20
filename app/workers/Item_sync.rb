# encoding: UTF-8
# frozen_string_literal: true

class ItemSync
  include Sidekiq::Worker

  def process(item)
    begin
      # call the Item Sync Service to sync the data
      ItemSyncService.new(item).process
    rescue ItemSyncServiceError => e
      logger.error {"Worker::ItemSync ERROR: #{e.message}"}
    end
  end
end
