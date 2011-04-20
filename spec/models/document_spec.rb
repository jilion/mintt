require 'spec_helper'

describe Document do
  before(:each) do
    @f = mock('file', :original_filename => 'course_document.pdf', :read => '')
  end
  after(:each) do
    Dir.entries(Rails.root.join("public/uploads/documents/#{Time.now.year}/#{Time.now.month}/#{Time.now.day}")).each do |f|
      File.delete("public/uploads/documents/#{Time.now.year}/#{Time.now.month}/#{Time.now.day}/#{f}") if f =~ /course_document/
    end
  end

  context "from Factory" do
    subject { Factory.build(:document, :file => @f) }

    its(:title) { should =~ /A document \d+/ }
    its(:file)  { should be_present          }

    it { should be_valid }
  end

  describe "Validations" do
    [:title, :description, :module_id, :file, :published_at].each do |attribute|
      it { should allow_mass_assignment_of(attribute) }
    end

    it { should validate_presence_of(:title).with_message(I18n.t('mongoid.errors.messages.blank', :attribute => 'Title')) }

    it "without file" do
      document = Factory.build(:document, :file => nil)
      document.should_not be_valid
      document.errors[:file].should == [I18n.t('mongoid.errors.messages.blank', :attribute => 'File')]
    end
  end

  describe "Callbacks" do
    describe "before_create :save_file" do
      it "sets the filename" do
        Factory(:document, :file => @f).filename.should =~ /course_document_\d+\.pdf/
      end

      it "sets the right Mime::Type" do
        Factory(:document, :file => @f).mime_type.should == "application/pdf"
      end

      it "creates file on disk" do
        doc = Factory(:document, :file => @f)
        File.file?(File.new("#{Rails.root}/public#{doc.url}")).should be_true
      end
    end
  end

  describe "Instance Methods" do
    describe "#url" do
      it "returns entire url with upload folder and filename" do
        doc = Factory(:document, :file => @f)
        doc.url.should == "/#{doc.upload_folder.join('/')}/#{doc.filename}"
      end
    end

    describe "#extension" do
      it "returns extension" do
        Factory(:document, :file => @f).extension.should == 'pdf'
      end
    end

    describe "#image?" do
      it "is image with jpg image extension" do
        @f.stub(:original_filename).and_return('coursé_document.jpg')
        Factory(:document, :file => @f).should be_image
      end

      it "is image with jpeg image extension" do
        @f.stub(:original_filename).and_return('coursé_document.jpeg')
        Factory(:document, :file => @f).should be_image
      end

      it "is image with gif image extension" do
        @f.stub(:original_filename).and_return('coursé_document.gif')
        Factory(:document, :file => @f).should be_image
      end

      it "is image with png image extension" do
        @f.stub(:original_filename).and_return('coursé_document.png')
        Factory(:document, :file => @f).should be_image
      end

      it "isn't image with an image extension" do
        @f.stub(:original_filename).and_return('coursé_document.pdf')
        Factory(:document, :file => @f).should_not be_image
      end
    end

    describe "#published?" do
      it "is published" do
        Factory(:document, :file => @f, :published_at => 2.days.ago).should be_published
      end

      it "isn't published?" do
        Factory(:document, :file => @f, :published_at => 2.days.from_now).should_not be_published
      end
    end

    describe "#method_missing" do
      it "dynamicaly checks extension (pdf)" do
        @f.stub(:original_filename).and_return('coursé_document.pdf')
        Factory(:document, :file => @f).should be_pdf
      end

      it "dynamicaly checks extension (pages)" do
        @f.stub(:original_filename).and_return('coursé_document.pages')
        Factory(:document, :file => @f).should be_pages
      end
    end

    describe "#upload_folder" do
      it "returns an array with the year, month and day of Time.now.utc" do
        doc = Factory.build(:document, :file => @f)
        doc.upload_folder.should == %W[uploads documents #{Time.now.utc.year} #{Time.now.utc.month} #{Time.now.utc.day}]
      end

      it "returns an array with the year, month and day of created_at" do
        doc = Factory(:document, :file => @f)
        doc.upload_folder.should == %W[uploads documents #{doc.created_at.year} #{doc.created_at.month} #{doc.created_at.day}]
      end
    end

  end

end
