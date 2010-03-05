NEW_MESSAGE_RECIPIENT = case Rails.env
when "development", "test"
  ['remy@jilion.com']
when "production"
  ['mintt@epfl.ch']
end

NEW_APPLICATION_CC = case Rails.env
when "development", "test"
  ['remy@jilion.com']
when "production"
  ['mehdi.aminian@epfl.ch'] # add rosina
end

MINTT_SENDER = ['mintt@epfl.ch']

MINTT_EPFL = "mintt.epfl.ch"
MINTT_LOCAL = "mintt.local"