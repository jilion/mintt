require 'spec_helper'

feature "Admin teachers index" do
  background do
    ActionMailer::Base.deliveries.clear
    @teachers = 3.times.inject([]) { |memo, i| memo << Factory(:teacher) }
    visit '/admin'
  end

  it "should be possible to list teachers" do
    click_link "Teachers"

    current_url.should =~ %r(^http://[^/]+/admin/teachers$)
    page.should have_content("Teachers")

    page.should have_css("tr#teacher_#{@teachers.first.id}")
    page.should have_css("tr#teacher_#{@teachers.last.id}")
    page.should have_css("tr", :count => 4)
  end
end

feature "Admin teachers invitation" do
  background do
    ActionMailer::Base.deliveries.clear
    visit '/admin/teachers'
  end

  it "should be possible to invite teacher" do
    click_link "Invite a teacher"

    current_url.should =~ %r(^http://[^/]+/admin/teachers/invitation/new$)
    page.should have_content("New teacher invitation")

    fill_in "Email", :with => "test@test.com"
    click_button "Send invitation"

    current_url.should =~ %r(^http://[^/]+/admin/teachers$)
    ActionMailer::Base.deliveries.size.should == 1
  end
end

feature "Admin teachers show" do
  background do
    @teacher = Factory(:teacher)
    visit '/admin/teachers'
  end

  it "should be possible to edit a teacher" do
    click_link @teacher.name

    current_url.should =~ %r(^http://[^/]+/admin/teachers/#{@teacher.id}$)
    page.should have_content("Teacher: #{@teacher.name}")
  end
end

feature "Admin teachers edit" do
  background do
    @teacher = Factory(:teacher)
    visit '/admin/teachers'
  end

  it "should be possible to edit a teacher" do
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
