print "Creating the 'New message' mail template => "
MailTemplate.create(:title => 'user_registration_confirmation', :content => "Dear {{user.first_name}} {{user.last_name}},\nwe've received your request for participating in the Mintt program.\n\nTo confirm you demand, please click on the link below :\n{{user.confirmation_link}}\n\n\nThanks for your interest in the Mintt program,\n\nthe whole Mintt team.")
print "created.\n\n"
