require 'spec_helper'

feature "Admin" do
  feature "/admin/mail_templates" do
    background do
      @mail_templates = 3.times.inject([]) { |memo, i| memo << Factory(:mail_template) }
      visit '/admin'
    end

    it "lists mail templates" do
      click_link "Mail templates"

      current_url.should =~ %r(^http://[^/]+/admin/mail_templates$)
      page.should have_content("Mail templates")

      page.should have_css("tr#mail_template_#{@mail_templates.first.id}")
      page.should have_css("tr#mail_template_#{@mail_templates.last.id}")
      page.should have_css("tr", :count => 4+3)
    end
  end

  feature "/admin/mail_templates/:id" do
    background do
      @mail_template = Factory(:mail_template)
      visit '/admin/mail_templates'
    end

    it "shows a mail template" do
      click_link @mail_template.title.titleize

      current_url.should =~ %r(^http://[^/]+/admin/mail_templates/#{@mail_template.id}$)
      page.should have_content("Mail template: #{@mail_template.title.titleize}")
    end
  end

  feature "/admin/mail_templates/:id/edit" do
    background do
      @mail_template = Factory(:mail_template)
      visit '/admin/mail_templates'
    end

    it "edits a mail template" do
      within("#mail_template_#{@mail_template.id}") do
        click_link "edit"
      end

      current_url.should =~ %r(^http://[^/]+/admin/mail_templates/#{@mail_template.id}/edit$)
      page.should have_content("Edit mail template: #{@mail_template.title.titleize}")

      fill_in 'mail_template_content', :with => "Remy"
      click_button "Update mail template"

      current_url.should =~ %r(^http://[^/]+/admin/mail_templates$)

      @mail_template.reload
      @mail_template.content.should == "Remy"
    end
  end

end
