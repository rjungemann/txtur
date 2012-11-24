class Post < ActiveRecord::Base

  include ActionView::Helpers::TextHelper
  include ActionView::Helpers::SanitizeHelper

  attr_accessible :title, :contents, :public, :post_tags

  validates_presence_of :title
  validates_presence_of :markdown_contents

  has_many :taggings, :dependent => :destroy
  has_many :tags, :through => :taggings
  has_many :stars

  class << self

    def uuid
      UUIDTools::UUID.random_create.to_s
    end

    def for_user_id(user_id)
      self.where :facebook_id => user_id
    end

    def for_uuid(uuid)
      self.where :uuid => uuid
    end

    def public
      self.where :public => true
    end

    def starred
      self.where('star_count > 0').order 'star_count DESC'
    end

    def recent
      self.order 'updated_at DESC'
    end

    def by_created
      self.order 'created_at DESC'
    end

  end

  def contents=(raw_contents)
    self.markdown_contents = raw_contents

    # Allow referencing of other posts

    regex = /\@[a-f0-9]{8}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{12}/i

    link_contents = raw_contents.gsub regex do |match|
      uuid = match[1..-1]
      post = Post.where(:uuid => uuid).first

      return match unless post

      "<a href=\"/posts/#{uuid}\">#{post.title}</a>"
    end

    self.html_contents = RDiscount.new(link_contents).to_html.chomp
  end

  def summary
    truncate strip_tags(self.html_contents.strip), :length => 100
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

  def update_star_count!
    star_count = Star.where(:post_id => self.id).count

    self.update_attribute :star_count, star_count
  end

end

