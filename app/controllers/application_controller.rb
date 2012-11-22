class ApplicationController < ActionController::Base

  protect_from_forgery

  before_filter :authenticate!

  def authenticate!
    config = YAML.load_file(Rails.root.join 'config/facebook.yml')[Rails.env]
    oauth  = Koala::Facebook::OAuth.new config['app_id'], config['secret_key']

    @facebook_cookies ||= oauth.get_user_info_from_cookie cookies

    if @facebook_cookies
      @user_id      = @facebook_cookies['user_id']
      @access_token = @facebook_cookies['access_token']
      @graph        = Koala::Facebook::GraphAPI.new @access_token
    end
  end

end

