require 'spec_helper'

describe ApplicationHelper do
  
  # ================
  # = display_date =
  # ================
  describe "display_date" do
    describe "with a blank date" do
      it "should render nothing" do
        date = nil
        helper.display_date(date).should == ""
      end
    end
    
    describe "with a valid date" do
      it "should render well" do
        date = Date.new(2010, 03, 01)
        helper.display_date(date).should == "March 01, 2010"
      end
    end
  end
  
  # =============
  # = sexy_date =
  # =============
  describe "sexy_date" do
    describe "with a blank date" do
      it "should render nothing" do
        date = nil
        helper.sexy_date(date).should == ""
      end
    end
    
    describe "with a today date" do
      it "should render nothing" do
        date = Time.now
        helper.sexy_date(date).should == "Today"
      end
    end
    
    describe "with a yesterday date" do
      it "should render nothing" do
        date = Time.now.yesterday
        helper.sexy_date(date).should == "Yesterday"
      end
    end
    
    describe "with a date before yesterday" do
      it "should render nothing" do
        date = 3.days.ago
        helper.sexy_date(date).should == "#{date.strftime("%B")} #{date.strftime("%d")}, #{date.strftime("%Y")}"
      end
    end
  end
  
  # =============
  # = sexy_time =
  # =============
  describe "sexy_time" do
    describe "with a blank time" do
      it "should render nothing" do
        date = nil
        helper.sexy_time(date).should == ""
      end
    end
    
    describe "with a valid date" do
      it "should render nothing" do
        date = 3.days.ago
        helper.sexy_time(date).should == "#{date.strftime("%I")}:#{date.strftime("%M")} #{date.strftime("%p")}"
      end
    end
    
    describe "with a valid time" do
      it "should render nothing" do
        time = Time.now
        helper.sexy_time(time).should == "#{time.strftime("%I")}:#{time.strftime("%M")} #{time.strftime("%p")}"
      end
    end
  end
  
  # =============
  # = words_count =
  # =============
  describe "words_count" do
    describe "with a blank text" do
      it "should return '0 words'" do
        text = nil
        helper.words_count(text).should == "0 words"
      end
    end
    
    describe "with a 1-word text" do
      it "should return '1 word'" do
        text = "word!"
        helper.words_count(text).should == "1 word"
      end
    end
    
    describe "with a x-words text (with x > 1)" do
      it "should render 'x words'" do
        text = "this is a text with 7 words"
        helper.words_count(text).should == "7 words"
      end
    end
  end
  
end