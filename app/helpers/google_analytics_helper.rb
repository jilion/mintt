module GoogleAnalyticsHelper
  
  def google_analytics
    if Rails.env.production?
      content_tag(:script, :type => "text/javascript") do
        "var _gaq = _gaq || [];
        _gaq.push(['_setAccount', 'UA-10280941-6']);
        _gaq.push(['_setDomainName', 'mintt.epfl.ch']);
        _gaq.push(['_trackPageview']);
        
        (function() {
          var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
          ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
          (document.getElementsByTagName('head')[0] || document.getElementsByTagName('body')[0]).appendChild(ga);
        })();"
      end
    end
  end
  
end
