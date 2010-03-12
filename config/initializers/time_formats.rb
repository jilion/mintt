Date::DATE_FORMATS[:lite] = "%B %d, %Y"
Date::DATE_FORMATS[:full] = "%B %d, %Y %I:%M %p"
Date::DATE_FORMATS[:time] = "%I:%M %p"

Time::DATE_FORMATS[:lite] = "%B %d, %Y"
Time::DATE_FORMATS[:full] = "%B %d, %Y %I:%M %p"
Time::DATE_FORMATS[:time] = "%I:%M %p"
#   Time::DATE_FORMATS[:short_ordinal] = lambda { |time| time.strftime("%B #{time.day.ordinalize}") }