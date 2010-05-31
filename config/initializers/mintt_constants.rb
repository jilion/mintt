NEW_MESSAGE_RECIPIENTS = case Rails.env
when "development", "test"
  ['remy@jilion.com']
when "production"
  ['mehdi.aminian@epfl.ch', 'rosina.amendola@epfl.ch']
end

MINTT_SENDER = "mintt@epfl.ch"

MINTT_EPFL = "mintt.epfl.ch"
MINTT_LOCAL = "mintt.local"

REGISTRATION_OPEN = Rails.env.development? ? true : false