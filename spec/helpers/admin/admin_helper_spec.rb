require 'spec_helper'

describe Admin::AdminHelper do
  
  # ===================
  # = sort_parameters =
  # ===================
  describe "sort_parameters" do
    describe "with nil field" do
      it "should return a default hash with :order_by => field" do
        helper.sort_parameters(nil)[:order_by].should be_nil
      end
    end
    
    describe "with a field and no params" do
      it "should return a default hash with :order_by => field" do
        helper.sort_parameters('name').should == { :all => nil, :order_by => 'name', :sort_way => 'asc' }
      end
    end
    
    describe "with a field and params[:all]" do
      it "should return a default hash with :all => params[:all]" do
        params[:all] = true
        helper.sort_parameters('name')[:all].should be_true
        
        params[:all] = false
        helper.sort_parameters('name')[:all].should be_false
      end
    end
    
    describe "with a field == params[:order_by] and a valid params[:sort_way] (asc or desc)" do
      it "should invert the sort_way (asc => desc)" do
        params[:order_by] = 'name'
        params[:sort_way] = 'asc'
        helper.sort_parameters('name')[:sort_way].should == 'desc'
        
        params[:order_by] = 'name'
        params[:sort_way] = 'desc'
        helper.sort_parameters('name')[:sort_way].should == 'asc'
      end
    end
    
    describe "with a field and invalid params[:sort_way] (not asc nor desc)" do
      it "should return a default hash with :sort_way => 'asc'" do
        params[:all] = true
        params[:sort_way] = 'foo'
        helper.sort_parameters('name')[:sort_way].should == 'asc'
      end
    end
  end
  
  # ===================
  # = invert_sort_way =
  # ===================
  describe "invert_sort_way" do
    describe "with nil field" do
      it "should return 'asc'" do
        helper.invert_sort_way(nil) == 'asc'
      end
    end
    
    describe "with a field == params[:order_by] and no params[:sort_way]" do
      it "should return 'asc'" do
        params[:order_by] = 'name'
        helper.invert_sort_way('name') == 'asc'
      end
    end
    
    describe "with a field == params[:order_by] and params[:sort_way] == 'asc'" do
      it "should return 'desc'" do
        params[:order_by] = 'name'
        params[:sort_way] = 'asc'
        helper.invert_sort_way('name') == 'desc'
      end
    end
    
    describe "with a field == params[:order_by] and params[:sort_way] == 'desc'" do
      it "should return 'asc'" do
        params[:order_by] = 'name'
        params[:sort_way] = 'desc'
        helper.invert_sort_way('name') == 'asc'
      end
    end
    
    describe "with a field != params[:order_by] and params[:sort_way]" do
      it "should always return 'asc'" do
        params[:order_by] = 'foo'
        params[:sort_way] = 'asc'
        helper.invert_sort_way('name') == 'asc'
        
        params[:sort_way] = 'desc'
        helper.invert_sort_way('name') == 'asc'
      end
    end
  end
  
  # =========================================
  # = smart_objects_objects_displayed_range =
  # =========================================
  describe "smart_objects_objects_displayed_range" do
    describe "with a nil collection" do
      it "should return 0" do
        helper.smart_objects_objects_displayed_range(nil) == 0
      end
    end
    
    describe "with a collection responding to total_entries" do
      it "should return a beautiful range between the index(+1) of the first element of the current page and the minimum between the index of the last element of the current page and the total entries" do
        35.times { Factory.create(:user) }
        collection = User.paginate(:page => 2, :per_page => 10)
        helper.smart_objects_objects_displayed_range(collection).should == "11-20"
        
        collection = User.paginate(:page => 4, :per_page => 10)
        helper.smart_objects_objects_displayed_range(collection).should == "31-35"
      end
    end
    
    describe "with a collection not responding to total_entries" do
      it "should return collection.size" do
        collection = (0..10).to_a
        helper.smart_objects_objects_displayed_range(collection).should == 11
      end
    end
  end
  
  # =======================
  # = smart_objects_count =
  # =======================
  describe "smart_objects_count" do
    describe "with a nil collection" do
      it "should return 0" do
        helper.smart_objects_count(nil).should == 0
      end
    end
    
    describe "with a collection responding to total_entries" do
      it "should return collection.total_entries" do
        35.times { Factory.create(:user) }
        collection = User.paginate(:page => 2)
        helper.smart_objects_count(collection).should == 35
      end
    end
    
    describe "with a collection not responding to total_entries" do
      it "should return collection.size" do
        collection = (0..10).to_a
        helper.smart_objects_count(collection).should == 11
      end
    end
  end
  
end