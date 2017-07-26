class NotificationService
  # In order to publish message we need a exchange name.
  # Note that RabbitMQ does not care about the payload -
  # we will be using JSON-encoded strings
  def self.notify(message = {})
    # grab the fanout exchange
    connection = Bunny.new
    connection.start

    channel = connection.create_channel
    x = channel.fanout("deal.notifications")
    # and simply publish message
    x.publish(message.to_json)
    connection.close
  end

  # def self.channel
  #   @channel ||= connection.create_channel
  # end

  # We are using default settings here
  # The `Bunny.new(...)` is a place to
  # put any specific RabbitMQ settings
  # like host or port
  # def self.connection
  #   @connection ||= Bunny.new.tap do |c|
  #     c.start
  #   end
  # end
end
