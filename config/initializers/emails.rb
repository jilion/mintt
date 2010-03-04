NEW_MESSAGE_RECIPIENT = case Rails.env
when "development", "test"
  ['remy@jilion.com']
when "production"
  ['mintt@epfl.ch']
end

MINTT_SENDER = ['mintt@epfl.ch']