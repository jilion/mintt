require 'spec_helper'

feature "/admin/teachers" do
  background do
    ActionMailer::Base.deliveries.clear
    @teachers = 3.times.inject([]) { |memo, i| memo << Factory(:teacher) }
    visit '/admin'
  end

  it "lists teachers" do
    click_link "Teachers"

    current_url.should =~ %r(^http://[^/]+/admin/teachers$)
    page.should have_content("#{Time.now.utc.year} Teachers")
    page.should have_content("Teachers not active in #{Time.now.utc.year}")

    page.should have_css("tr#teacher_#{@teachers.first.id}")
    page.should have_css("tr#teacher_#{@teachers.last.id}")
    page.should have_css("table", :count => 2)
  end
end

feature "/admin/teachers/invitation/new" do
  background do
    ActionMailer::Base.deliveries.clear
    visit '/admin/teachers'
  end

  it "invites teacher" do
    click_link "Invite a teacher"

    current_url.should =~ %r(^http://[^/]+/admin/teachers/invitation/new$)
    page.should have_content("New teacher invitation")

    fill_in "Email", :with => "test@test.com"
    click_button "Send invitation"

    current_url.should =~ %r(^http://[^/]+/admin/teachers$)
    ActionMailer::Base.deliveries.size.should == 1
  end
end

feature "/admin/teachers/:id" do
  background do
    @teacher = Factory(:teacher)
    visit '/admin/teachers'
  end

  it "shows a teacher" do
    click_link @teacher.name

    current_url.should =~ %r(^http://[^/]+/admin/teachers/#{@teacher.id}$)
    page.should have_content("Teacher: #{@teacher.name}")
  end
end

feature "/admin/teachers/:id/edit" do
  background do
    @teacher = Factory(:teacher)
    visit '/admin/teachers'
  end

  it "edits a teacher" do
    within("#teacher_#{@teacher.id}") do
      click_link "edit"
    end

    current_url.should =~ %r(^http://[^/]+/admin/teachers/#{@teacher.id}/edit$)
    page.should have_content("Edit teacher: #{@teacher.name}")

    fill_in 'Name', :with => "Remy"
    click_button "Update teacher"

    current_url.should =~ %r(^http://[^/]+/admin/teachers$)

    @teacher.reload
    @teacher.name.should == "Remy"
  end
end

feature "/admin/teachers/:id (delete)" do
  background do
    @teacher1 = Factory(:teacher)
    @teacher2 = Factory(:teacher)
    Teacher.count.should == 2
    visit '/admin/teachers'
  end

  it "deletes a teacher" do
    within("#teacher_#{@teacher2.id}") do
      click_button "delete"
    end

    Teacher.count.should == 1
    current_url.should =~ %r(^http://[^/]+/admin/teachers$)
  end
end
