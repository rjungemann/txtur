class Tag < ActiveRecord::Base

  attr_accessible :name

  validates_uniqueness_of :name

  has_many :taggings, :dependent => :destroy
  has_many :posts, :through => :taggings

  class << self

    def reap_orphaned!
      Tag.find_each do |tag|
        tag.destroy if tag.taggings.empty?
      end
    end

    def recent
      self.order :updated_at
    end

    def for_name(name)
      self.where :name => name
    end

  end

end

