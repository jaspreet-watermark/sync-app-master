# encoding: UTF-8
# frozen_string_literal: true

class ItemSyncService
  ItemSyncServiceError = Class.new(StandardError)

  attr_accessor :item

  # initialize the item
  def initialize(item)
    @item = item
  end

  # this service will try to sync the data to slave app
  # In case of any error, it will raise ItemSyncServiceError
  def process
    begin
      item_params = Serializers::ItemEvent.call(item)
      response = connection.post do |req|
        req.url '/api/v1/items'
        req.headers['Content-Type'] = 'application/json'
        req.body = item_params.to_json
      end
      if response.status == 200
        item.sync_success
      else
        item.sync_failed
      end
    rescue => e
      item.sync_failed
      raise ItemSyncServiceError, "Error while Sync in ItemSyncService!"
    end
  end

  def connection
    Faraday.new(:url => 'http://localhost:4000')
  end
end
