class OneTime

  def self.set_users_school_and_lab
    User.all.each do |user|
      user.update_attribute(:school_and_lab, "#{user.school} (lab: #{user.lab})")
    end
  end

end
