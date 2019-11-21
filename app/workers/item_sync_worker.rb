# encoding: UTF-8
# frozen_string_literal: true

class ItemSyncWorker
  include Sidekiq::Worker
  sidekiq_options retry: 5

  # (i.e. 10, 15, 20, 25, 30)
  sidekiq_retry_in { |c, e| 5 * (c + 1) }

  def perform(item_id)
    begin
      # call the Item Sync Service to sync the data
      item = Item.unscoped.find(item_id)
      ItemSyncService.new(item).process
    rescue Exception => e
      logger.error {"Worker::ItemWorker ERROR: #{e.message}"}
      raise e
    end
  end
end
