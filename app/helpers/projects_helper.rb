module ProjectsHelper
  def vid_embed_video(video_url)
    if video_url[/(?:http\:\/\/)?(?:www\.)?(vimeo|youtube)\.com\/(?:watch\?v=)?(.*?)(?:\z|$|&)/]
      video_server = $1
      video_path = $2
    else 
      video_url[/(?:https\:\/\/)?(?:www\.)?youtu.be\/([^\?]*)/]
      video_server = "tiny"
      video_path = $1
    end
    if video_server == ("vimeo")
      %Q{<iframe height="250" width="443" src="http://player.vimeo.com/video/#{ video_path }" frameborder="0" allowfullscreen></iframe>}
    else
      %Q{<iframe height="250" width="443" src="http://www.youtube.com/embed/#{ video_path }?wmode=transparent" frameborder="0" allowfullscreen></iframe>}
    end
  end
  
  def editpage_embed_video(video_url)
    if video_url[/(?:http\:\/\/)?(?:www\.)?(vimeo|youtube)\.com\/(?:watch\?v=)?(.*?)(?:\z|$|&)/]
      video_server = $1
      video_path = $2
    else 
      video_url[/(?:https\:\/\/)?(?:www\.)?youtu.be\/([^\?]*)/]
      video_server = "tiny"
      video_path = $1
    end
    if video_server == ("vimeo")
      %Q{<iframe height="173" width="306" src="http://player.vimeo.com/video/#{ video_path }" frameborder="0" allowfullscreen></iframe>}
    else
      %Q{<iframe height="173" width="306" src="http://www.youtube.com/embed/#{ video_path }?wmode=transparent" frameborder="0" allowfullscreen></iframe>}
    end
  end
  
  def vid_link(video_url)
    if video_url[/(?:http\:\/\/)?(?:www\.)?(vimeo|youtube)\.com\/(?:watch\?v=)?(.*?)(?:\z|$|&)/]
      video_server = $1
      video_path = $2
    else 
      video_url[/(?:https\:\/\/)?(?:www\.)?youtu.be\/([^\?]*)/]
      video_server = "tiny"
      video_path = $1
    end
    if video_server == ("vimeo")
      %Q{http://player.vimeo.com/video/#{ video_path }}
    else
      %Q{http://www.youtube.com/embed/#{ video_path }?wmode=transparent}
    end
  end
  
  def truncate(text, max_sentences = 2, max_words = 40)
    # Take first 2 setences (blah. blah. blah)
    three_sentences = text.split('. ').slice(0, max_sentences).join('. ')
    # Take first 30 words of the above
    shortened = three_sentences.split(' ').slice(0, max_words).join(' ')
    return shortened
  end
  
end
