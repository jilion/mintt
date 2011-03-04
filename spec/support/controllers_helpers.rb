module Spec
  module Support
    module ControllerHelpers

      def mock_document(stubs={})
        @mock_document ||= mock_model(Document, stubs)
      end

      def mock_user(stubs = {})
        @mock_user ||= mock_model(User, stubs)
      end

      def mock_teacher(stubs={})
        @mock_teacher ||= mock_model(Teacher, stubs)
      end

      def authenticated_teacher(stubs = {})
        unless @current_teacher
          @current_teacher = mock_model(Teacher, stubs.reverse_merge(:confirmed? => true))
          Admin.stub(:find) { @current_teacher }
        end
        @current_teacher
      end

      def authenticated_user(stubs = {})
        unless @current_user
          User.stub(:find) { @current_user }
          @current_user = mock_model(User, stubs.reverse_merge(:active? => true, :confirmed? => true, :suspended? => false))
        end
        @current_user
      end

      def mock_mail_template(stubs = {})
        @mock_mail_template ||= mock_model(MailTemplate, stubs)
      end

      def mock_message(stubs={})
        @mock_message ||= mock_model(Message, stubs)
      end

    end
  end
end

RSpec.configuration.include(Spec::Support::ControllerHelpers)
