require 'spec_helper'

feature "Teaching modules index" do
  background do
    ActionMailer::Base.deliveries.clear
    @teaching_modules = 3.times.inject([]) { |memo, i| memo << Factory(:teaching_module, :year => Time.now.utc.year) }
    visit '/admin'
  end

  it "should be possible to list teachers" do
    click_link "Modules"

    current_url.should =~ %r(^http://[^/]+/admin/modules$)
    page.should have_content("Modules (2011)")

    page.should have_css("tr#teaching_module_#{@teaching_modules.first.id}")
    page.should have_css("tr#teaching_module_#{@teaching_modules.last.id}")
    page.should have_css("tr", :count => 4)
  end
end

feature "GET /admin/modules/:id" do
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

feature "GET /admin/modules/:id/edit" do
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

feature "DELETE /admin/modules/:id" do
  background do
    @teaching_module1 = Factory(:teaching_module, :year => Time.now.utc.year)
    @teaching_module2 = Factory(:teaching_module, :year => Time.now.utc.year)
    TeachingModule.count.should == 2
    visit '/admin/modules'
  end

  feature "last teaching module" do
    it "deletes a teaching module" do
      within("#teaching_module_#{@teaching_module2.id}") do
        click_button "delete"
      end

      TeachingModule.count.should == 1
      current_url.should =~ %r(^http://[^/]+/admin/modules$)
      page.should have_content("Module successfully destroyed")
    end
  end
end
