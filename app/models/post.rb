class Post < ActiveRecord::Base

  include ActionView::Helpers::TextHelper
  include ActionView::Helpers::SanitizeHelper

  attr_accessible :title, :contents

  def self.uuid
    UUIDTools::UUID.random_create.to_s
  end

  def contents=(raw_contents)
    self.markdown_contents = raw_contents
    self.html_contents     = RDiscount.new(raw_contents).to_html
  end

  def summary
    truncate strip_tags(self.html_contents.strip), :length => 150
  end

end

