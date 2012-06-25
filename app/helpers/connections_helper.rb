module ConnectionsHelper

  def provider_image(provider)
    image_tag "icon-#{provider}.png", size: "48x48", alt: "#{provider}"
  end

  def widget_facebook_like(url)
    content_for :javascript do
      content_tag(:div, '', id: 'fb-root')
      javascript_tag do
        "(function(d, s, id) {
          var js, fjs = d.getElementsByTagName(s)[0];
          if (d.getElementById(id)) {return;}
          js = d.createElement(s); js.id = id;
          js.src = '//connect.facebook.net/en_US/all.js#xfbml=1';
          fjs.parentNode.insertBefore(js, fjs);
        }(document, 'script', 'facebook-jssdk'));"
      end
    end
    content_tag(:div, '', class: 'fb-like', data: { href: url, send: false, layout: 'button_count', width: nil, :'show-faces' => 'false'} )
  end

  def widget_google_plus_one(url)
    content_for :javascript do
      javascript_tag do
        "(function() {
          var po = document.createElement('script'); po.type = 'text/javascript'; po.async = true;
          po.src = 'https://apis.google.com/js/plusone.js';
          var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(po, s);
        })();"
      end
    end
    content_tag(:div, '', class: 'g-plusone', data: { href: url, size: 'tall', annotation: 'none' } )
  end

  def widget_tweet(url, via, text )
    content_for :javascript do
      javascript_include_tag '//platform.twitter.com/widgets.js'
    end
    link_to 'Tweet', 'https://twitter.com/share', class: "twitter-share-button", data: { url: url, via: via, text: text }
  end

  def widget_twitter_feed(options={})
    limit = (options[:limit] || 0) - 1
    twitter_client.user_timeline[0..limit].map do |tweet|
      tweet.oembed({hide_thread: true, hide_media: true}).html
    end.join.html_safe
  end

  def twitter_client(connection=global_twitter_connection)
    return false if connection.nil?
    @twitter_client ||= Twitter::Client.new(
      oauth_token: connection.token,
      oauth_token_secret: connection.secret
    )
  end
private

  def global_twitter_connection
    @global_twitter_connection ||= Connection.where(connectable_type: 'Settings', provider: 'twitter').first
  end


end