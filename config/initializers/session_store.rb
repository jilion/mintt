Mintt::Application.config.session_store :cookie_store, :key => '_mintt.epfl.ch_session', :expire_after => 3600

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# Mintt::Application.config.session_store :active_record_store