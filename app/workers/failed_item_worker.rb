# encoding: UTF-8
# frozen_string_literal: true

class FailedItemWorker
  include Sidekiq::Worker
  sidekiq_options queue: :daemons, retry: false

  # this worker will run every 10 seconds
  # It will traverse all failed sync records
  # and call the ItemSyncService with the item object
  def perform
    logger.info {"*** Worker::FailedItem INFO: Begin at #{current_time} : Found #{Item.failed.count} Failed Records ***"}
    success = 0
    failed = 0
    Item.unscoped.failed.each do |item|
      begin
        # call the Item Sync Service to sync the data
        ItemSyncService.new(item).process
        success += 1
      rescue Exception => e
        failed += 1
        logger.error {"Worker::FailedItem ERROR: #{e.message}"}
      end
    end
    logger.info {"*** Total Success Synced Records: #{success} ***"}
    logger.info {"*** Total Failed Synced Records: #{failed} ***"}
    logger.info {"*** Worker::FailedItem INFO: End at #{current_time} ***"}
    FailedItemWorker.perform_in(5.seconds)
  end

  private
  def current_time
    Time.current.strftime("%B %d, %Y %I:%M %p")
  end
end
