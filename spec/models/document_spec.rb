require 'spec_helper'

describe Document do

  context "with valid attributes" do
    subject { Factory(:document) }

    its(:title)    { should == "A document" }
    its(:filename) { should be_present      }

    it { should be_valid }
  end

  describe "should be invalid" do

    it "without filename" do
      Factory.build(:document, :filename => nil).should_not be_valid
    end

  end

  describe "should be valid" do
    it "without title" do
      Factory.build(:document, :title => nil).should be_valid
    end

    it "without module_id" do
      Factory.build(:document, :module_id => nil).should be_valid
    end
  end

  describe "Instance Methods" do

    describe "#file=" do
      before(:each) do
        @f = File.new(Rails.root.join("spec/fixtures/course_document.pdf"))
        @f.stub(:original_filename).and_return('course_document.pdf')
      end

      it "should set filename from file" do
        Factory(:document, :file => @f).filename.should == "course_document.pdf"
      end
      it "should set filename from file" do
        doc = Factory(:document, :file => @f)
        File.file?(File.new("#{Rails.root}/public#{doc.url}")).should be_true
      end
    end

    describe "#url" do
      it "should return entire url with upload folder and filename" do
        Factory(:document, :filename => "image.jpg").url.should == "/#{Document.upload_folder.join('/')}/image.jpg"
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

    describe "#published?" do
      it "should be published?" do
        Factory(:document, :published_at => 2.days.ago).should be_published
      end

      it "should not be published?" do
        Factory(:document, :published_at => 2.days.from_now).should_not be_published
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

    describe "#method_missing" do
      it "should dynamicaly check extension" do
        Factory(:document, :filename => "image.pdf").should be_pdf
        Factory(:document, :filename => "image.pages").should be_pages
      end
    end

  end

end
