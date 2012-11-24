class Star < ActiveRecord::Base

  belongs_to :post

  class << self

    def for_user_id(user_id)
      self.where :facebook_id => user_id
    end

    def for_post_id(post_id)
      self.where :post_id => post_id
    end

    def recent
      self.order 'updated_at DESC'
    end

  end

end

