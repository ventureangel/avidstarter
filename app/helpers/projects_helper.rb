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
  
end