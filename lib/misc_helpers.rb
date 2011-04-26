module MiscHelpers

  class << self
    def run(*cmd)
      system(*cmd)
      raise "Command #{cmd.inspect} failed!" unless $?.success?
    end

    def timed(active=true, &block)
      return unless active

      if block_given?
        start_time = Time.now.utc
        yield
        print "\tDone in #{Time.now.utc - start_time}s!\n\n"
      else
        print "\n\nYou must pass a block to this method!\n\n"
      end
    end

    def delete_all_files_in_public(path, options={})
      options.reverse_merge!({ :quiet => false, :timed => true, :match => nil })

      if path.gsub('.', '') =~ /\w+/ # don't remove all files and directories in /public ! ;)
        print "Deleting all files and directories in /public/#{path}\n" unless options[:quiet]
        timed(options[:timed]) do
          Dir["#{Rails.public_path}/#{path}/**/*"].sort { |a,b| b.size <=> a.size }.each do |filename|
            File.delete(filename) if File.file?(filename) && (options[:match].nil? || filename =~ options[:match])
          end
          Dir["#{Rails.public_path}/#{path}/**/*"].sort { |a,b| b.size <=> a.size }.each do |filename|
            Dir.delete(filename) if File.directory?(filename) && Dir.entries(filename).size == 2
          end
        end
      end
    end

    def disable_perform_deliveries(&block)
      if block_given?
        original_perform_deliveries = ActionMailer::Base.perform_deliveries
        # Disabling perform_deliveries (avoid to spam fakes email adresses)
        ActionMailer::Base.perform_deliveries = false

        yield

        # Switch back to the original perform_deliveries
        ActionMailer::Base.perform_deliveries = original_perform_deliveries
      else
        print "\n\nYou must pass a block to this method!\n\n"
      end
    end
  end

end