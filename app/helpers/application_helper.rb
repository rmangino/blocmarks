module ApplicationHelper

  def form_group_tag(errors, &block)
    if errors.any?
      content_tag :div, capture(&block), class: 'form-group has-error'
    else
      content_tag :div, capture(&block), class: 'form-group'
    end
  end

  def description_and_image_for_url(url, maxwidth = 75)
    embedly_api = Embedly::API.new(key: ENV['EMBEDLY_KEY'])
    obj = embedly_api.oembed(url: url, image_width: maxwidth, type: 'photo').first

    return obj[:description], obj[:thumbnail_url]
  end

end
