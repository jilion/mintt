module FinderExtension
  
  def self.included(base)
    base.extend ClassMethods
  end
  
  module ClassMethods
    def method_and_options_for_paginate(params={})
      paginate?(params) ? [:paginate, { :page => params[:page], :per_page => self.per_page || 15 }] : [:all, {}]
    end
    
  protected
    
    def paginate?(params)
      !params.key?(:all)
    end
  end
  
end