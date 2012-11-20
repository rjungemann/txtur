class Post < ActiveRecord::Base

  attr_accessible :title, :contents

  def contents=(raw_contents)
    self.markdown_contents = raw_contents
    self.html_contents     = RDiscount.new(raw_contents).to_html
  end

end

