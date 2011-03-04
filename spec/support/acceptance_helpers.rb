module Spec
  module Support
    module AcceptanceHelpers

      def warden
        request.env['warden']
      end

      def user_application(options={})
        user = Factory(:user, options[:user] || {})
        user.confirm! unless options[:confirm] == false
        user
      end

      def selected_user(options={})
        user = user_application(options)
        user.update_attributes(:state => 'selected')
        user
      end

      def selected_with_password_user(options={})
        user = selected_user(options)
        user.password = '123456'
        user.password_confirmation = '123456'
        user.save
        user
      end

      def sign_in_as_user(options={}, &block)
        @current_user ||= begin
          user = selected_with_password_user(options)
          visit "/users/login"
          fill_in 'Email',    :with => user.email
          fill_in 'Password', :with => '123456'
          check   'Remember me' if options[:remember_me] == true
          yield if block_given?
          click_button 'Log in'
          user
        end
      end

      def invited_teacher(options={})
        teacher = Teacher.invite(:email => "test@test.com")
        teacher
      end

      def invited_with_password_teacher(options={})
        teacher = invited_teacher(options)
        Teacher.accept_invitation(:invitation_token => teacher.invitation_token, :password => '123456', :password_confirmation => '123456')
        teacher
      end

      def sign_in_as_teacher(options={}, &block)
        @current_teacher ||= begin
          teacher = invited_with_password_teacher(options)
          visit "/teachers/login"
          fill_in 'Email',    :with => teacher.email
          fill_in 'Password', :with => '123456'
          check   'Remember me' if options[:remember_me] == true
          yield if block_given?
          click_button 'Log in'
          teacher
        end
      end

      def sign_out
        click_link "Log out"
      end

    end
  end
end

RSpec.configuration.include(Spec::Support::AcceptanceHelpers, :type => :request)
