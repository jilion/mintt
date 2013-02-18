module Admin::TeachersHelper

  def teacher_active_years(teacher)
    if teacher.years.size > 2
      [teacher.years.first, '...', teacher.years.last]
    else
      teacher.years
    end.join(', ')
  end

end
