class TeachingModule
  include Mongoid::Document
  include Mongoid::Timestamps
  include FinderExtension

  field :module_id, :type => Integer
  field :title,     :type => String
  field :year,      :type => Integer, :default => Time.now.utc.year

  index [:year, :module_id]

  cattr_accessor :per_page
  @@per_page = 15

  attr_accessible :title, :year

  # ===============
  # = Validations =
  # ===============
  validates :title, :year, :presence => true
  validates :module_id, :title, :uniqueness => { :scope => :year }

  # =============
  # = Callbacks =
  # =============
  before_create :set_module_id
  before_destroy :prevent_deletion

  # ==========
  # = Scopes =
  # ==========
  scope :year, lambda { |year| where(:year => year) }

  # =================
  # = Class Methods =
  # =================

  def self.index_order_by(params={})
    method, options = method_and_options_for_paginate(params)
    scopes = year(params[:year].try(:to_i) || Time.now.utc.year)
    scopes.order_by([params[:order_by] || :published_at, params[:sort_way] || :desc]).send(method, options)
  end

  def self.years_for_select
    (2010..Time.now.utc.year).to_a
  end

  def self.modules_for_select(year)
    year = Time.now.utc.year if year.nil?
    TeachingModule.year(year).map { |m| ["#{m.module_id} - #{m.title}", m.module_id] }
  end

  # ====================
  # = Instance Methods =
  # ====================

  def destroyable?
    module_id == TeachingModule.year(year).max(:module_id)
  end

private

  def set_module_id
    self.module_id = TeachingModule.year(self.year).count
  end

  def prevent_deletion
    if !destroyable?
      self.errors.add(:base, "Can't be deleted")
      false
    else
      true
    end
  end

end
