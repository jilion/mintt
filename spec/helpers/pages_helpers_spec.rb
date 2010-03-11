require 'spec_helper'

describe PagesHelper do
  
  describe "module_box" do
    describe "called with a block" do
      it "should render the block inside a module box" do
        # helper.module_box { "This is a test" }.should == "<li><div class=\"wrap\"><div class=\"back\">This is a test</div><div class=\"spacer\"></div></div><div class=\"bottom\"></div></li>"
      end
    end
  end
  
end