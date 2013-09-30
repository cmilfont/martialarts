module VideosHelper
  
  def get_thumb video
    youtube_url = video.try(:link)
    if youtube_url[/youtu\.be\/([^\?]*)/]
      youtube_id = $1
    else
      # Regex from # http://stackoverflow.com/questions/3452546/javascript-regex-how-to-get-youtube-video-id-from-url/4811367#4811367
      youtube_url[/^.*((v\/)|(embed\/)|(watch\?))\??v?=?([^\&\?]*).*/]
      youtube_id = $5
    end
    "<img src=\"http://img.youtube.com/vi/#{youtube_id}/1.jpg\"/>".html_safe
  end
  
end