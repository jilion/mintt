Factory.define :user do |f|
  f.sequence(:email)  { |n| "email#{n}@epfl.com" }
end
