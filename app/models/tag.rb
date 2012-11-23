class Tag < ActiveRecord::Base

  attr_accessible :name

  validates_uniqueness_of :name

  has_many :taggings, :dependent => :destroy
  has_many :posts, :through => :taggings

  def self.reap_orphaned!
    Tag.find_each do |tag|
      tag.destroy if tag.taggings.empty?
    end
  end

end

