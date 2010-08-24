module IntegrationHelper
  
  def warden
    request.env['warden']
  end
  
  def user_application(options = {})
    user = Factory(:user, options[:user] || {})
    user.confirm! unless options[:confirm] == false
    user
  end
  
  def selected_user(options = {})
    user = user_application(options.merge(:state => 'selected'))
    visit edit_user_password_url(:reset_password_token => user.reset_password_token)
    fill_in "Password",              :with => "123456"
    fill_in "Password confirmation", :with => "123456"
    click_button "Set my password"
    user
  end
  
  def sign_in_as_user(options = {}, &block)
    user = selected_user(options)
    visit "/users/login"
    fill_in 'Email',    :with => user.email
    fill_in 'Password', :with => '123456'
    check   'Remember me' if options[:remember_me] == true
    yield if block_given?
    click_button 'Log in'
    user
  end
  
end