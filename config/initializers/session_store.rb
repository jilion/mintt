# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_MiNT_session',
  :secret      => 'c351b8ea2491105876d94c759d24e7ab2509db0e97b809fc10fb54386d41d918330d35d7205ae78379174558053fd7f5fd8cb80b7b9dbe2de0779923e2f74bfb'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
