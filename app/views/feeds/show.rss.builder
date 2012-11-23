xml.instruct! :xml, :version => '1.0'
xml.rss :version => '2.0' do
  xml.channel do
    xml.title "Txtur Feed for #{ @user_info['name'] }"
    xml.description 'Txtur lets you simply write, then share it with your friends with zero friction. Share a short story, poem, or other snippet of text with people on Facebook.'
    xml.link url_for(:controller => 'feeds', :action => 'show', :id => @facebook_id, :only_path => false)

    for post in @posts
      xml.item do
        xml.title post.title
        xml.description post.html_contents
        xml.pubDate post.created_at.to_s(:rfc822)

        url = url_for(:controller => 'posts', :action => 'show', :id => post.uuid, :only_path => false)

        xml.link url
        xml.guid url
      end
    end
  end
end

