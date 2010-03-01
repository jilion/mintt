module PagesHelper

  def module_box(&block)
    haml_tag :li do
      haml_tag :div, {:class => 'top'}
      haml_tag :div, {:class => 'wrap'} do
        haml_tag :div, {:class => 'back'} do
          haml_concat capture_haml(&block)
        end
        haml_tag :div, {:class => 'spacer'}
      end
      haml_tag :div, {:class => 'bottom'}
    end
    
  end
  
end