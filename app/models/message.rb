class Message
  include Mongoid::Document
  include Mongoid::Timestamps
  include FinderExtension

  field :sender_name,  :type => String
  field :sender_email, :type => String
  field :content,      :type => String
  field :read_at,      :type => Time, :default => nil
  field :replied_at,   :type => Time, :default => nil
  field :trashed_at,   :type => Time, :default => nil

  cattr_accessor :per_page
  @@per_page = 15

  attr_accessible :sender_name, :sender_email, :content, :read_at, :replied_at, :trashed_at

  # ===============
  # = Validations =
  # ===============
  validates :sender_name, :sender_email, :content, :presence => true
  validates :sender_email, :format => { :with => Devise.email_regexp }

  # =============
  # = Callbacks =
  # =============
  after_create :notify_of_new_message

  # ==========
  # = Scopes =
  # ==========
  scope :trashed, lambda { |trashed|  where(trashed ? { :trashed_at.ne => nil } : { :trashed_at => nil }) }

  # =================
  # = Class Methods =
  # =================
  def self.index_order_by(params={})
    method, options = method_and_options_for_paginate(params)
    trashed(params[:trashed]).order_by([params[:order_by] || :confirmed_at, params[:sort_way] || :desc]).send(method, options)
  end

  # ====================
  # = Instance Methods =
  # ====================
  def unread?
    read_at.nil?
  end

  def read?
    !unread?
  end

  def unreplied?
    replied_at.nil?
  end

  def replied?
    !unreplied?
  end

  def trashed?
    trashed_at.present?
  end

  def sender_name
    read_attribute(:sender_name).present? ? read_attribute(:sender_name).titleize : ""
  end

protected

  def self.order_hash(options = {})
    { :order => "#{options[:order_by] || 'created_at'} #{options[:sort_way] || 'desc'}" }
  end

  # after_create
  def notify_of_new_message
    MinttMailer.new_message(self).deliver
  end

end