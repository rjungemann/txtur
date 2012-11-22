class Post < ActiveRecord::Base

  include ActionView::Helpers::TextHelper
  include ActionView::Helpers::SanitizeHelper

  attr_accessible :title, :contents, :public, :post_tags

  validates_presence_of :title
  validates_presence_of :markdown_contents

  has_many :taggings, :dependent => :destroy
  has_many :tags, :through => :taggings

  def self.uuid
    UUIDTools::UUID.random_create.to_s
  end

  def contents=(raw_contents)
    self.markdown_contents = raw_contents
    self.html_contents     = RDiscount.new(raw_contents).to_html.chomp
  end

  def summary
    truncate strip_tags(self.html_contents.strip), :length => 150
  end

  def post_tags=(tag_string)
    self.tags.delete_all

    tag_string.split(/\s*,\s*/).each do |tag_name|
      old_tag = Tag.where(:name => tag_name).first

      if old_tag
        if !self.tags.include?(old_tag)
          self.tags << old_tag
        end
      else
        tag = Tag.create :name => tag_name

        self.tags << tag
      end
    end
  end

  def post_tags
    self.tags.map(&:name).join ', '
  end

end

