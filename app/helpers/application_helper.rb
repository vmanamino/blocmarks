module ApplicationHelper
  def embed_thumbnail(url)
    meta = get_meta(url)
    thumbnail_image = meta['thumbnail_url']
    return image_tag(thumbnail_image) unless thumbnail_image.nil?
  end

  def get_url_title(url)
    meta = get_meta(url)
    url_title = meta['title']
    return url_title unless url_title.nil?
  end

  def get_url_description(url)
    meta = get_meta(url)
    url_description = meta['description']
    return url_description unless url_description.nil?
  end

  def get_url_video(url)
    meta = get_meta(url)
    url_video_embed = meta['html']
    return url_video_embed unless url_video_embed.nil?
  end

  def get_meta(url)
    require 'embedly'
    require 'json'
    embedly_api = Embedly::API.new key: ENV['EMBEDLY_KEY'], user_agent: 'Mozilla/5.0 (compatible; viral-blocmarks/1.0; vmanamino@gmail.com)'
    obj = embedly_api.oembed url: url
    json_obj = JSON.pretty_generate(obj[0].marshal_dump)
    meta = JSON.load(json_obj)
    meta
  end
end
