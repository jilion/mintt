require 'spec_helper'

describe Admin::AdminHelper do
  
  # ===================
  # = sort_parameters =
  # ===================
  describe "sort_parameters" do
    describe "with a field and no params" do
      it "should return a default hash with :order_by => field" do
        helper.sort_parameters('name').should == { :all => nil, :order_by => 'name', :sort_way => 'asc'  }
      end
    end
    
    describe "with a field and params" do
      it "should return a hash with 4 parameters" do
        params[:all] = true
        params[:sort_way] = 'foo'
        helper.sort_parameters('name').should == { :all => true, :order_by => 'name', :sort_way => 'asc'  }
      end
    end
    
    describe "with a field == params[:order_by] and params" do
      it "should invert the sort_way" do
        params[:order_by] = 'name'
        params[:sort_way] = 'asc'
        helper.sort_parameters('name')[:sort_way].should == 'desc'
      end
    end
  end
  
  # def sort_parameters(field)
  #   { :all => params[:all], :order_by => field, :sort_way => invert_sort_way(field), :page => params[:page] }
  # end
  
end