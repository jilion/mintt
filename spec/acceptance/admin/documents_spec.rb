require 'spec_helper'

feature "Admin documents index" do
  background do
    @documents = 3.times.inject([]) { |memo, i| memo << Factory(:document) }
    visit '/admin'
  end

  scenario "should be possible to list documents" do
    click_link "Documents"

    current_url.should =~ %r(^http://[^/]+/admin/documents$)
    page.should have_content("Documents")

    page.should have_css("tr#document_#{@documents.first.id}")
    page.should have_css("tr#document_#{@documents.last.id}")
    page.should have_css("tr", :count => 4)
  end

end

feature "Admin documents show" do
  background do
    @document = Factory(:document)
    visit '/admin/documents'
  end

  scenario "should be possible to edit a document" do
    click_link @document.title

    current_url.should =~ %r(^http://[^/]+/admin/documents/#{@document.id}$)
    page.should have_content("Document: #{@document.title}")
  end
end

feature "Admin documents edit" do
  background do
    @document = Factory(:document)
    visit '/admin/documents'
  end

  scenario "should be possible to edit a document" do
    within("#document_#{@document.id}") do
      click_link "edit"
    end

    current_url.should =~ %r(^http://[^/]+/admin/documents/#{@document.id}/edit$)
    page.should have_content("Edit document: #{@document.title}")

    fill_in 'Title', :with => "Remy"
    click_button "Update document"

    current_url.should =~ %r(^http://[^/]+/admin/documents$)

    @document.reload
    @document.title.should == "Remy"
  end
end
