require 'spec_helper'

feature "/admin/modules" do
  background do
    ActionMailer::Base.deliveries.clear
    @teaching_modules = 3.times.inject([]) { |memo, i| memo << Factory(:teaching_module, :year => Time.now.utc.year) }
    visit '/admin'
  end

  it "lists modules" do
    click_link "Modules"

    current_url.should =~ %r(^http://[^/]+/admin/modules$)
    page.should have_content("2011 Modules")

    page.should have_css("tr#teaching_module_#{@teaching_modules.first.id}")
    page.should have_css("tr#teaching_module_#{@teaching_modules.last.id}")
    page.should have_css("tr", :count => 4)
  end
end

feature "POST /admin/modules" do
  background do
    visit '/admin/modules'
  end

  it "creates a module" do
    click_link "New module"

    current_url.should =~ %r(^http://[^/]+/admin/modules/new$)
    page.should have_content("Create a new module")

    fill_in 'Title', :with => "Remy"
    select '2010', :from => "Year"
    click_button "Create module"

    current_url.should =~ %r(^http://[^/]+/admin/modules$)

    TeachingModule.count.should == 1
    TeachingModule.last.title.should == "Remy"
  end
end

feature "/admin/modules/:id" do
  background do
    @teaching_module = Factory(:teaching_module, :year => Time.now.utc.year)
    visit '/admin/modules'
  end

  it "shows a module" do
    click_link @teaching_module.title

    current_url.should =~ %r(^http://[^/]+/admin/modules/#{@teaching_module.id}$)
    page.should have_content("Module: #{@teaching_module.title}")
  end
end

feature "/admin/modules/:id/edit" do
  background do
    @teaching_module = Factory(:teaching_module, :year => Time.now.utc.year)
    visit '/admin/modules'
  end

  it "edits a module" do
    within("#teaching_module_#{@teaching_module.id}") do
      click_link "edit"
    end

    current_url.should =~ %r(^http://[^/]+/admin/modules/#{@teaching_module.id}/edit$)
    page.should have_content("Edit module: #{@teaching_module.title}")

    fill_in 'Title', :with => "Remy"
    click_button "Update module"

    current_url.should =~ %r(^http://[^/]+/admin/modules$)

    @teaching_module.reload
    @teaching_module.title.should == "Remy"
  end
end

feature "/admin/modules/:id (delete)" do
  background do
    @teaching_module1 = Factory(:teaching_module, :year => Time.now.utc.year)
    @teaching_module2 = Factory(:teaching_module, :year => Time.now.utc.year)
    TeachingModule.count.should == 2
    visit '/admin/modules'
  end

  it "deletes the last module" do
    within("#teaching_module_#{@teaching_module2.id}") do
      click_button "delete"
    end

    TeachingModule.count.should == 1
    current_url.should =~ %r(^http://[^/]+/admin/modules$)
    page.should have_content("Module successfully destroyed")
  end
end
