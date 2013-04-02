class EmailUniquenessValidator < ActiveModel::EachValidator

  def validate_each(record, attribute, new_email)
    if new_email.present? && active_user_with_same_email_exists?(record, new_email)
      record.errors.add(attribute, :taken)
    end
  end

  def active_user_with_same_email_exists?(record, new_email)
    User.where(:trashed_at => nil, :email => new_email, :year => record.year, :_id.ne => record.id).exists?
  end

end
