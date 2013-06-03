require 'spec_helper'

feature "/admin/documents" do
  background do
    @f = mock('file', :original_filename => 'course_document.pdf', :read => '')
    @documents = 3.times.inject([]) { |memo, i| memo << Factory(:document, :file => @f) }
    visit '/admin'
  end

  scenario "lists documents" do
    click_link "Documents"

    current_url.should =~ %r(^http://[^/]+/admin/documents$)
    page.should have_content("Documents")

    page.should have_css("tr#document_#{@documents.first.id}")
    page.should have_css("tr#document_#{@documents.last.id}")
    page.should have_css("tr", :count => 4)
  end

end

feature "/admin/documents/:id" do
  background do
    @f = mock('file', :original_filename => 'course_document.pdf', :read => '')
    @document = Factory(:document, :file => @f)
    visit '/admin/documents'
  end

  scenario "shows a document" do
    click_link @document.title

    current_url.should =~ %r(^http://[^/]+/admin/documents/#{@document.id}$)
    page.should have_content(@document.title)
  end
end

feature "/admin/documents/:id/edit" do
  background do
    @f = mock('file', :original_filename => 'course_document.pdf', :read => '')
    @document = Factory(:document, :file => @f)
    visit '/admin/documents'
  end

  scenario "edits a document" do
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
