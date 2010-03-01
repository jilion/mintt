# DO NOT MODIFY THIS FILE

require 'digest/sha1'
require "rubygems"

module Bundler
  module SharedHelpers

    def reverse_rubygems_kernel_mixin
      # Disable rubygems' gem activation system
      ::Kernel.class_eval do
        if private_method_defined?(:gem_original_require)
          alias rubygems_require require
          alias require gem_original_require
        end

        undef gem
      end
    end

    def default_gemfile
      gemfile = find_gemfile
      gemfile or raise GemfileNotFound, "The default Gemfile was not found"
      Pathname.new(gemfile)
    end

    def in_bundle?
      find_gemfile
    end

  private

    def find_gemfile
      return ENV['BUNDLE_GEMFILE'] if ENV['BUNDLE_GEMFILE']

      previous = nil
      current  = File.expand_path(Dir.pwd)

      until !File.directory?(current) || current == previous
        filename = File.join(current, 'Gemfile')
        return filename if File.file?(filename)
        current, previous = File.expand_path("#{current}/.."), current
      end
    end

    def clean_load_path
      # handle 1.9 where system gems are always on the load path
      if defined?(::Gem)
        me = File.expand_path("../../", __FILE__)
        $LOAD_PATH.reject! do |p|
          next if File.expand_path(p).include?(me)
          p != File.dirname(__FILE__) &&
            Gem.path.any? { |gp| p.include?(gp) }
        end
        $LOAD_PATH.uniq!
      end
    end

    extend self
  end
end

module Bundler
  LOCKED_BY    = '0.9.5'
  FINGERPRINT  = "778b0c7628849db2e4070c722f899ea38ec78e93"
  SPECS        = [
        {:version=>"2.3.5", :load_paths=>["/opt/local/lib/ruby/gems/1.8/gems/activesupport-2.3.5/lib"], :name=>"activesupport", :groups=>[:default]},
        {:version=>"1.0.10", :load_paths=>["/Users/octavez/Projects/Jilion/Customers/mintt/2010/www/vendor/bundler_gems/gems/daemons-1.0.10/lib"], :name=>"daemons", :groups=>[:developement]},
        {:version=>"2.3.5", :load_paths=>["/opt/local/lib/ruby/gems/1.8/gems/actionmailer-2.3.5/lib"], :name=>"actionmailer", :groups=>[:default]},
        {:version=>"0.43", :load_paths=>["/Users/octavez/Projects/Jilion/Customers/mintt/2010/www/vendor/bundler_gems/gems/linecache-0.43/lib"], :name=>"linecache", :groups=>[:test]},
        {:version=>"0.10.3", :load_paths=>["/Users/octavez/Projects/Jilion/Customers/mintt/2010/www/vendor/bundler_gems/gems/ruby-debug-base-0.10.3/lib"], :name=>"ruby-debug-base", :groups=>[:test]},
        {:version=>"1.0.0", :load_paths=>["/opt/local/lib/ruby/gems/1.8/gems/devise-1.0.0/lib"], :name=>"devise", :groups=>[:default]},
        {:version=>"0.9.7", :load_paths=>["/opt/local/lib/ruby/gems/1.8/gems/formtastic-0.9.7/lib"], :name=>"formtastic", :groups=>[:default]},
        {:version=>"2.5.0", :load_paths=>["/Users/octavez/Projects/Jilion/Customers/mintt/2010/www/vendor/bundler_gems/gems/cgi_multipart_eof_fix-2.5.0/lib"], :name=>"cgi_multipart_eof_fix", :groups=>[:developement]},
        {:version=>"0.2.3", :load_paths=>["/Users/octavez/Projects/Jilion/Customers/mintt/2010/www/vendor/bundler_gems/gems/gem_plugin-0.2.3/lib"], :name=>"gem_plugin", :groups=>[:developement]},
        {:version=>"1.8.1", :load_paths=>["/opt/local/lib/ruby/gems/1.8/gems/jnunemaker-validatable-1.8.1/lib"], :name=>"jnunemaker-validatable", :groups=>[:default]},
        {:version=>"2.2.19", :load_paths=>["/opt/local/lib/ruby/gems/1.8/gems/haml-2.2.19/lib"], :name=>"haml", :groups=>[:default]},
        {:version=>"0.18.3", :load_paths=>["/opt/local/lib/ruby/gems/1.8/gems/mongo_ext-0.18.3/ext"], :name=>"mongo_ext", :groups=>[:default]},
        {:version=>"0.8.7", :load_paths=>["/opt/local/lib/ruby/gems/1.8/gems/rake-0.8.7/lib"], :name=>"rake", :groups=>[:default]},
        {:version=>"2.3.5", :load_paths=>["/opt/local/lib/ruby/gems/1.8/gems/activerecord-2.3.5/lib"], :name=>"activerecord", :groups=>[:default]},
        {:version=>"0.3.1", :load_paths=>["/Users/octavez/Projects/Jilion/Customers/mintt/2010/www/vendor/bundler_gems/gems/columnize-0.3.1/lib"], :name=>"columnize", :groups=>[:test]},
        {:version=>"1.0.7", :load_paths=>["/opt/local/lib/ruby/gems/1.8/gems/fastthread-1.0.7/lib", "/opt/local/lib/ruby/gems/1.8/gems/fastthread-1.0.7/ext"], :name=>"fastthread", :groups=>[:developement]},
        {:version=>"1.1.5", :load_paths=>["/Users/octavez/Projects/Jilion/Customers/mintt/2010/www/vendor/bundler_gems/gems/mongrel-1.1.5/lib", "/Users/octavez/Projects/Jilion/Customers/mintt/2010/www/vendor/bundler_gems/gems/mongrel-1.1.5/ext"], :name=>"mongrel", :groups=>[:developement]},
        {:version=>"1.0.1", :load_paths=>["/opt/local/lib/ruby/gems/1.8/gems/rack-1.0.1/lib"], :name=>"rack", :groups=>[:default]},
        {:version=>"0.9.2", :load_paths=>["/opt/local/lib/ruby/gems/1.8/gems/warden-0.9.2/lib"], :name=>"warden", :groups=>[:default]},
        {:version=>"2.3.5", :load_paths=>["/opt/local/lib/ruby/gems/1.8/gems/actionpack-2.3.5/lib"], :name=>"actionpack", :groups=>[:default]},
        {:version=>"2.3.5", :load_paths=>["/opt/local/lib/ruby/gems/1.8/gems/activeresource-2.3.5/lib"], :name=>"activeresource", :groups=>[:default]},
        {:version=>"2.3.5", :load_paths=>["/opt/local/lib/ruby/gems/1.8/gems/rails-2.3.5/lib"], :name=>"rails", :groups=>[:default]},
        {:version=>"0.18.3", :load_paths=>["/opt/local/lib/ruby/gems/1.8/gems/mongo-0.18.3/lib"], :name=>"mongo", :groups=>[:default]},
        {:version=>"0.7.0", :load_paths=>["/opt/local/lib/ruby/gems/1.8/gems/mongo_mapper-0.7.0/lib"], :name=>"mongo_mapper", :groups=>[:default]},
        {:version=>"0.10.3", :load_paths=>["/Users/octavez/Projects/Jilion/Customers/mintt/2010/www/vendor/bundler_gems/gems/ruby-debug-0.10.3/cli"], :name=>"ruby-debug", :groups=>[:test]},
      ]
  AUTOREQUIRES = {:test=>[["ruby-debug", false]], :default=>[["mongo_mapper", false], ["haml", false], ["formtastic", false], ["devise", false], ["warden", false]], :developement=>[["mongrel", false]]}

  extend SharedHelpers

  def self.cripple_ruby_gems
    reverse_rubygems_kernel_mixin
    patch_rubygems
  end

  def self.match_fingerprint
    print = Digest::SHA1.hexdigest(File.read(File.expand_path('../../Gemfile', __FILE__)))
    unless print == FINGERPRINT
      abort 'Gemfile changed since you last locked. Please `bundle lock` to relock.'
    end
  end

  def self.setup(*groups)
    match_fingerprint
    SPECS.each do |spec|
      spec[:load_paths].each { |path| $LOAD_PATH.unshift path }
    end
  end

  def self.require(*groups)
    groups = [:default] if groups.empty?
    groups.each do |group|
      (AUTOREQUIRES[group] || []).each do |file, explicit|
        if explicit
          Kernel.require file
        else
          begin
            Kernel.require file
          rescue LoadError
          end
        end
      end
    end
  end

  def self.patch_rubygems
    specs = SPECS

    ::Kernel.send(:define_method, :gem) do |dep, *reqs|
      opts = reqs.last.is_a?(Hash) ? reqs.pop : {}

      dep  = dep.name if dep.respond_to?(:name)
      unless specs.any?  { |s| s[:name] == dep }
        e = Gem::LoadError.new "#{dep} is not part of the bundle. Add it to Gemfile."
        e.name = dep
        e.version_requirement = reqs
        raise e
      end

      true
    end
  end

  # Setup bundle when it's required.
  cripple_ruby_gems
  setup
end
