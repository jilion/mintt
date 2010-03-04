module MinttLiquidFilters
  class User::LiquidDropClass
    include ActionView::Helpers::UrlHelper
    include ActionController::UrlWriter
    include Admin::UsersHelper
    
    def full_name
      user_full_name(self)
    end
    
    def confirmation_link
      link_to('Confirm my account', { :controller => 'confirmations', :action => 'show', :confirmation_token => self.confirmation_token })
    end
  end
end