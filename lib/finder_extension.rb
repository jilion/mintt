module FinderExtension
  
  def self.included(base)
    base.extend ClassMethods
  end
  
  module ClassMethods
    def method_and_options(params = {})
      paginate?(params) && self.respond_to?(:per_page) ? [:paginate, { :page => params[:page], :per_page => self.per_page }] : [:all, {}]
    end
    
  protected
    
    def paginate?(params)
      !params.key?(:all)
    end
  end
  
end