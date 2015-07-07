module ApplicationHelper
  def embed_thumbnail(url)
    image_tag(get_meta(url)['thumbnail_url'])
  end

  def get_url_title(url)
    get_meta(url)['title']
  end

  def get_url_description(url)
    get_meta(url)['description']
  end

  def get_url_video(url)
    get_meta(url)['html']
  end

  def get_meta(url)
    require 'embedly'
    require 'json'
    embedly_api = Embedly::API.new key: ENV['EMBEDLY_KEY'], user_agent: 'Mozilla/5.0 (compatible; viral-blocmarks/1.0; vmanamino@gmail.com)' # rubocop:disable Metrics/LineLength
    obj = embedly_api.oembed url: url
    json_obj = JSON.pretty_generate(obj[0].marshal_dump)
    meta = JSON.load(json_obj)
    meta
  end
end
