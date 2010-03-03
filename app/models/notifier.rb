class Notifier < ActionMailer::Base

  def new_message(message)
    recipients NEW_MESSAGE_RECIPIENT
    # bcc        ["bcc@example.com", "Order Watcher <watcher@example.com>"]
    from       MINTT_SENDER
    sent_on      Time.now
    content_type "text/html"
    subject    "[Mintt] New contact message"
    body       :message => message
  end

end
