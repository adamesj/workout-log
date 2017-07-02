class MessagesChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  # This is the server side code

  def checkIn(data)
    room_id = "#{data['room_id']}"
    stream_from "messages_room_#{room_id}"
  end

  def checkOut(data)
    stop_all_streams
  end
end
