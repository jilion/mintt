require 'spec_helper'

describe MailTemplate do
  # Waiting for remarkable_mongo to work...
  # it { should have_keys(:sender_name, :sender_email, :content, String) }
  # it { should have_keys(:read, :replied, Boolean) }
  # it { should validate_presence_of(:sender_name, :sender_email, :content) }

  before(:all) do
    @t = Factory.create(:mail_template)
  end
  
  describe "default" do
    subject { Factory(:mail_template) }

    its(:title) { should == "new_message" }
    its(:content) { should == "{{user.first_name}} {{user.last_name}}<{{user.email}}>\n\nThat's a demo template!\n\n{{confirmation_link}}" }

    it { should be_valid }
  end
  
  it "should retrieve existing template" do
    MailTemplate.find_by_title('new_message').should eql(@t)
  end

  describe "should be invalid" do
    it "without title" do
      Factory(:mail_template, :title => nil).should_not be_valid
    end

    it "without content" do
      Factory(:mail_template, :content => nil).should_not be_valid
    end
  end

end
