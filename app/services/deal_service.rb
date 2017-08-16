class DealService
  def self.broadcast_changes(deal)
    raise "DealService broadcast_changes is only work for Deal object and not
           supported #{deal.class} object." if not deal.is_a?(Deal)
    connection = Bunny.new
    connection.start
    channel = connection.create_channel
    message = deal.attributes
    message["model_name.singular"] = deal.model_name.singular
    message["model_name.plural"] = deal.model_name.plural
    message["model_name.human"] = deal.model_name.human
    x = channel.fanout("deal.deal_changes")
    # and simply publish message
    x.publish(message.to_json)
    connection.close
  end
end
