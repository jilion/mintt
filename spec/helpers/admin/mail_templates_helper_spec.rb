require 'spec_helper'

describe Admin::MailTemplatesHelper do

  # =======================
  # = mail_template_title =
  # =======================
  describe "mail_template_title" do
    describe "with nil mail_template" do
      it "returns nothing" do
        helper.mail_template_title(nil).should == ''
      end
    end

    describe "with a valid mail_template" do
      it "returns the titleized mail_template's title" do
        helper.mail_template_title(Factory(:mail_template, :title => "a lame title")).should == "A Lame Title"
      end
    end
  end

end
