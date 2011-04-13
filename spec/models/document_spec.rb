require 'spec_helper'

describe Document do

  context "from Factory" do
    subject { Factory.build(:document) }

    its(:title)    { should =~ /A document \d+/ }
    its(:filename) { should be_present          }

    it { should be_valid }
  end

  describe "Validations" do
    [:title, :description, :module_id, :file, :published_at].each do |attribute|
      it { should allow_mass_assignment_of(attribute) }
    end

    it { should validate_presence_of(:title).with_message(I18n.t('mongoid.errors.messages.blank', :attribute => 'Title')) }

    it "without filename" do
      document = Factory.build(:document, :filename => nil)
      document.should_not be_valid
      document.errors[:file].should == [I18n.t('mongoid.errors.messages.blank', :attribute => 'File')]
    end

    it "without title" do
      Factory.build(:document, :title => nil).should be_valid
    end
  end

  describe "Callbacks" do
    before(:each) do
      @f = File.new(Rails.root.join("spec/fixtures/coursé_document.pdf"))
      @f.stub(:original_filename).and_return('coursé_document.pdf')
    end

    it "should set the right Mime::Type" do
      Factory(:fake_document, :file => @f).mime_type.should == "application/pdf"
    end
  end

  describe "Instance Methods" do

    describe "#file=" do
      before(:each) do
        @f = File.new(Rails.root.join("spec/fixtures/coursé_document.pdf"))
        @f.stub(:original_filename).and_return('coursé_document.pdf')
      end

      it "should set filename from file" do
        Factory(:fake_document, :file => @f).filename.should == "course_document.pdf"
      end

      it "should set filename from file" do
        doc = Factory(:fake_document, :file => @f)
        File.file?(File.new("#{Rails.root}/public#{doc.url}")).should be_true
      end
    end

    describe "#url" do
      it "should return entire url with upload folder and filename" do
        doc = Factory(:document, :filename => "image.jpg")
        doc.url.should == "/#{doc.upload_folder.join('/')}/image.jpg"
      end
    end

    describe "#extension" do
      it "should return extension" do
        Factory(:document, :filename => "image.test.2.jpg").extension.should == 'jpg'
      end
    end

    describe "#title" do
      it "should return title if present" do
        Factory(:document, :filename => "image.test.2.jpg", :title => "Great image").title.should == "Great image"
      end

      it "should return filename if title is not present" do
        Factory(:document, :filename => "image.test.2.jpg", :title => nil).title.should == "image.test.2.jpg"
      end
    end

    describe "#image?" do
      it "should be image with jpg image extension" do
        Factory(:document, :filename => "image.jpg").should be_image
        Factory(:document, :filename => "image.jpeg").should be_image
        Factory(:document, :filename => "image.gif").should be_image
        Factory(:document, :filename => "image.png").should be_image
      end

      it "should not be image with an image extension" do
        Factory(:document, :filename => "document.pdf").should_not be_image
      end
    end

    describe "#published?" do
      it "should be published?" do
        Factory(:document, :published_at => 2.days.ago).should be_published
      end

      it "should not be published?" do
        Factory(:document, :published_at => 2.days.from_now).should_not be_published
      end
    end

    describe "#method_missing" do
      it "should dynamicaly check extension" do
        Factory(:document, :filename => "image.pdf").should be_pdf
        Factory(:document, :filename => "image.pages").should be_pages
      end
    end

    describe "#upload_folder" do
      it "should return an array with the year, month and day of Time.now.utc" do
        doc = Factory.build(:document, :filename => "image.pdf")
        doc.upload_folder.should == %W[uploads documents #{Time.now.utc.year} #{Time.now.utc.month} #{Time.now.utc.day}]
      end

      it "should return an array with the year, month and day of created_at" do
        doc = Factory(:document, :filename => "image.pdf")
        doc.upload_folder.should == %W[uploads documents #{doc.created_at.year} #{doc.created_at.month} #{doc.created_at.day}]
      end
    end

  end

end
