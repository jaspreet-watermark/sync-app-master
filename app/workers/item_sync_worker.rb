# encoding: UTF-8
# frozen_string_literal: true

class ItemSyncWorker
  include Sidekiq::Worker
  sidekiq_options queue: :default, retry: false

  def perform(item_id)
    begin
      # call the Item Sync Service to sync the data
      item = Item.unscoped.find(item_id)
      ItemSyncService.new(item).process
    rescue Exception => e
      logger.error {"Worker::ItemWorker ERROR: #{e.message}"}
    end
  end
end
