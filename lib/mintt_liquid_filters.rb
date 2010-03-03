module MinttLiquidFilters
  class User::LiquidDropClass
    include ActionView::Helpers::UrlHelper
    include ActionController::UrlWriter
    
    def confirmation_link
      link_to('Confirm my account', {:host => ActionMailer::Base.default_url_options[:host], :controller => 'confirmations', :action => 'show', :confirmation_token => self.confirmation_token})#user_confirmation_url({:host => ActionMailer::Base.default_url_options[:host], :confirmation_token => self.confirmation_token}))
    end
  end
end