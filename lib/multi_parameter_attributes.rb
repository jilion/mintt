# http://gist.github.com/245094 (http://groups.google.com/group/mongomapper/browse_frm/thread/cd6e9d27d576aac4/3bdbe54462403765?lnk=gst&q=date#3bdbe54462403765)
module MultiParameterAttributes
  
  def attributes=(attributes)
    return if attributes.blank?
    
    multi_parameter_attributes = []
    attributes.each do |k, v|
      if k.to_s.include?("(")
        multi_parameter_attributes << [ k, v ]
      else
        writer_method = "#{k}="
        if respond_to?(writer_method)
          self.send(writer_method, v)
        else
          self[k.to_s] = v
        end
      end
    end
    
    assign_multiparameter_attributes(multi_parameter_attributes)
  end
  
  def assign_multiparameter_attributes(pairs)
    execute_callstack_for_multiparameter_attributes(
      extract_callstack_for_multiparameter_attributes(pairs)
    )
  end
  
  def execute_callstack_for_multiparameter_attributes(callstack)
    callstack.each do |name, values_with_empty_parameters|
      values = values_with_empty_parameters.reject(&:blank?)
      
      key = self.class.keys[name]
      raise ArgumentError, "Unknown key #{name}" if key.nil?
      klass = key.type
      
      # if the user has selected a complete attribute
      if values.size == values_with_empty_parameters.size
        value = if Time == klass
          Time.zone.local(*values)
        elsif Date == klass
          begin
            # values = values_with_empty_parameters.collect { |v| v.blank? ? 0 : v }
            Date.new(*values)
          rescue ArgumentError => ex # if Date.new raises an exception on an invalid date
            Time.zone.local(*values).to_date # we instantiate Time object and convert it back to a date thus using Time's logic in handling invalid dates
          end
        else
          klass.new(*values)
        end
        
        writer_method = "#{name}="
        if respond_to?(writer_method)
          self.send(writer_method, value)
        else
          self[name.to_s] = value
        end
        
      # the user entered a bad formatted attribute (empty or incomplete)
      else
        send(name + "=", values.empty? ? nil : klass.new)
      end
    end
  end
  
  def extract_callstack_for_multiparameter_attributes(pairs)
    attributes = { }
    
    for pair in pairs
      multiparameter_name, value = pair
      attribute_name = multiparameter_name.split("(").first
      attributes[attribute_name] = [] unless attributes.include?(attribute_name)
      
      attributes[attribute_name] << [ find_parameter_position(multiparameter_name), value ]
    end
    
    attributes.each { |name, values| attributes[name] = values.sort_by { |v| v.first }.collect { |v| v.last } }
  end
  
  def find_parameter_position(multiparameter_name)
    multiparameter_name.scan(/\(([0-9]*).*\)/).first.first
  end
  
end