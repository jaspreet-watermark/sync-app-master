# encoding: UTF-8
# frozen_string_literal: true

class ItemSyncService
  ItemSyncServiceError = Class.new(StandardError)

  attr_accessor :item

  attr_reader :logger

  # initialize the item
  def initialize(item)
    @item = item
    @logger = Rails.logger
  end

  # this service will try to sync the data to slave app
  # In case of any error, it will raise ItemSyncServiceError
  def process
    begin
    #   TODO:: Code to Sync Item
    rescue => e
      raise ItemSyncServiceError, "Error while Sync in ItemSyncService!"
    end
  end
end
