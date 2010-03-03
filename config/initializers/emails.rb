NEW_MESSAGE_RECIPIENT = case Rails.env
when "development", "test"
  ['remy@jilion.com']
when "production"
  ['remy@jilion.com']
end

MINTT_SENDER = ['mintt@epfl.ch']